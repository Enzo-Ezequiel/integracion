"""Contrato 1.6.0: la configuración de cada microservicio vive en el KV de Consul y el
orquestador se publica en Traefik por Consul Catalog, no por labels del compose."""

import json
import os
import shutil
import subprocess
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPT = ROOT / "scripts" / "cargar-config-consul.sh"
MICROSERVICIOS = (
    "orquestador",
    "validacion-pdf",
    "extraccion-texto",
    "persistencia-actualizaciones",
    "persistencia-consultas",
)
# Lo único que sigue llegando por el entorno: cómo conectarse a Consul.
CONEXION = ("CONSUL_ENABLED", "CONSUL_HTTP_ADDR", "CONSUL_HTTP_TOKEN_FILE")


def _variables(archivo: Path) -> dict[str, str]:
    variables = {}
    for linea in archivo.read_text(encoding="utf-8").splitlines():
        if linea and not linea.startswith("#"):
            clave, _, valor = linea.partition("=")
            variables[clave] = valor
    return variables


class CargaDeConfiguracionTests(unittest.TestCase):
    """El script corre en el contenedor consul-config; acá, con un `consul` falso que
    anota cada llamada, sin Consul ni Docker."""

    def setUp(self):
        self.tmp = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, self.tmp)
        self.config = self.tmp / "config"
        self.config.mkdir()
        for ejemplo in (ROOT / "env").glob("*.env.example"):
            shutil.copy(ejemplo, self.config / ejemplo.stem)
        (self.config / "validacion.env").write_text(
            "# comentario\r\nPDF_MAX_SIZE_MB=5\r\nCONSUL_ENABLED=true\r\n"
            "VACIA=\r\n\r\nLOG_LEVEL=INFO\r\n",
            encoding="utf-8",
        )
        bin_dir = self.tmp / "bin"
        bin_dir.mkdir()
        self.registro = self.tmp / "llamadas.txt"
        falso = bin_dir / "consul"
        falso.write_text(
            "#!/bin/sh\n"
            'if [ "$2" = put ]; then\n'
            '  printf "put %s=%s\\n" "$3" "$(cat)" >> "$REGISTRO"\n'
            "else\n"
            '  echo "$*" >> "$REGISTRO"\n'
            "fi\n",
            encoding="utf-8",
            newline="\n",
        )
        falso.chmod(0o755)
        entorno = {
            **os.environ,
            "CONFIG_DIR": str(self.config),
            "REGISTRO": str(self.registro),
            "PATH": f"{bin_dir}{os.pathsep}{os.environ['PATH']}",
        }
        self.resultado = subprocess.run(
            ["sh", str(SCRIPT)], env=entorno, capture_output=True, text=True
        )
        self.llamadas = self.registro.read_text(encoding="utf-8").splitlines()

    def test_carga_cada_variable_bajo_el_nombre_del_servicio_en_consul(self):
        self.assertEqual(self.resultado.returncode, 0, self.resultado.stderr)
        self.assertIn("put config/validacion-pdf/PDF_MAX_SIZE_MB=5", self.llamadas)
        self.assertIn("put config/validacion-pdf/LOG_LEVEL=INFO", self.llamadas)
        for servicio in (
            "extraccion",
            "persistencia-actualizaciones",
            "persistencia-consultas",
            "orquestador",
        ):
            self.assertTrue(
                any(f" config/{servicio}/" in llamada for llamada in self.llamadas),
                servicio,
            )

    def test_borra_lo_anterior_para_no_dejar_variables_viejas(self):
        self.assertEqual(
            self.llamadas[0], "kv delete -recurse config/validacion-pdf/"
        )

    def test_no_carga_la_conexion_a_consul_ni_valores_vacios(self):
        self.assertFalse(any("CONSUL_ENABLED" in llamada for llamada in self.llamadas))
        self.assertFalse(any("VACIA" in llamada for llamada in self.llamadas))

    def test_no_muestra_los_valores(self):
        self.assertNotIn("PDF_MAX_SIZE_MB=5", self.resultado.stdout)
        self.assertIn("config/validacion-pdf/: 2 claves", self.resultado.stdout)


class ComposeTests(unittest.TestCase):
    def setUp(self):
        entorno = {
            **os.environ,
            "ORQUESTADOR_VERSION": "test",
            "VALIDACION_VERSION": "test",
            "EXTRACCION_VERSION": "test",
            "ACTUALIZACIONES_VERSION": "test",
            "CONSULTAS_VERSION": "test",
        }
        resultado = subprocess.run(
            ["docker", "compose", "config", "--format", "json"],
            cwd=ROOT,
            env=entorno,
            check=True,
            capture_output=True,
            text=True,
        )
        self.services = json.loads(resultado.stdout)["services"]

    def test_consul_config_carga_la_configuracion_antes_que_los_microservicios(self):
        cargador = self.services["consul-config"]
        self.assertEqual(cargador["restart"], "no")
        self.assertIn("config_loader_token", [s["source"] for s in cargador["secrets"]])
        montaje = next(v for v in cargador["volumes"] if v["target"] == "/config")
        self.assertTrue(montaje["read_only"])
        for nombre in MICROSERVICIOS:
            dependencia = self.services[nombre]["depends_on"]["consul-config"]
            self.assertEqual(
                dependencia["condition"], "service_completed_successfully"
            )

    def test_los_microservicios_solo_reciben_la_conexion_a_consul(self):
        for nombre in MICROSERVICIOS:
            servicio = self.services[nombre]
            self.assertNotIn("env_file", servicio, nombre)
            self.assertEqual(set(servicio["environment"]), set(CONEXION), nombre)
            self.assertEqual(servicio["environment"]["CONSUL_ENABLED"], "true")

    def test_ningun_servicio_publica_puertos_ni_labels_de_traefik(self):
        for nombre, servicio in self.services.items():
            self.assertNotIn("ports", servicio, nombre)
            etiquetas = servicio.get("labels", {})
            self.assertFalse(
                [e for e in etiquetas if e.startswith("traefik.")], nombre
            )


class EjemplosDeConfiguracionTests(unittest.TestCase):
    def test_los_env_no_repiten_la_conexion_a_consul(self):
        for ejemplo in (ROOT / "env").glob("*.env.example"):
            for clave in CONEXION:
                self.assertNotIn(clave, _variables(ejemplo), ejemplo.name)

    def test_el_orquestador_lleva_las_reglas_de_traefik_como_tags(self):
        variables = _variables(ROOT / "env" / "orquestador.env.example")
        self.assertEqual(variables["CONSUL_SERVICE_ADDRESS"], "orquestador")
        tags = json.loads(variables["CONSUL_SERVICE_TAGS"])
        self.assertIn("traefik.enable=true", tags)
        self.assertIn(
            "traefik.http.routers.orquestador.rule=Host(`pdf.universidad.localhost`)",
            tags,
        )
        self.assertIn("traefik.http.routers.orquestador.tls=true", tags)
        middlewares = next(
            t for t in tags if t.startswith("traefik.http.routers.orquestador.middlewares=")
        )
        self.assertIn("orquestador-cortocircuito", middlewares)
        self.assertIn("orquestador-limite", middlewares)
        self.assertTrue(
            any(".circuitbreaker.expression=" in t for t in tags), "cortocircuito"
        )
        self.assertTrue(any(".ratelimit.average=" in t for t in tags), "límite")


if __name__ == "__main__":
    unittest.main()
