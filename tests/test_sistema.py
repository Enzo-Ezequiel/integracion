"""scripts/sistema.sh: un solo comando para levantar, testear, mostrar y apagar el
sistema (automatización que pide la cátedra), también desde PowerShell."""

import shutil
import subprocess
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SCRIPTS = ROOT / "scripts"
COMANDOS = ("todo", "levantar", "tests", "demo", "grype", "apagar")


def correr(*argumentos: str) -> subprocess.CompletedProcess:
    return subprocess.run(
        [shutil.which("bash") or "bash", str(SCRIPTS / "sistema.sh"), *argumentos],
        capture_output=True,
        text=True,
    )


class SistemaTests(unittest.TestCase):
    def test_sin_comando_muestra_el_uso_con_todos_los_comandos(self):
        resultado = correr()
        self.assertEqual(resultado.returncode, 2)
        for comando in COMANDOS:
            self.assertIn(f"  {comando} ", resultado.stderr)

    def test_un_comando_desconocido_no_hace_nada(self):
        resultado = correr("borrar-todo")
        self.assertEqual(resultado.returncode, 2)
        self.assertIn("Uso:", resultado.stderr)

    def test_desde_powershell_se_llama_al_mismo_script(self):
        envoltorio = (SCRIPTS / "sistema.ps1").read_text(encoding="utf-8")
        self.assertIn("sistema.sh", envoltorio)
        self.assertIn("@args", envoltorio)
        self.assertIn("exit $LASTEXITCODE", envoltorio)

    def test_levantar_sh_usa_los_mismos_tests(self):
        # Una sola lista de suites: levantar.sh --tests delega en sistema.sh tests.
        levantar = (SCRIPTS / "levantar.sh").read_text(encoding="utf-8")
        self.assertIn("sistema.sh tests", levantar)

    def test_el_humo_espera_a_que_traefik_descubra_al_orquestador(self):
        # Traefik lee el catálogo de Consul cada 10 s (refreshInterval): recién levantado,
        # el orquestador da 404 por Traefik unos segundos aunque esté sano. Se reintenta
        # antes de dar el humo por fallado.
        levantar = (SCRIPTS / "levantar.sh").read_text(encoding="utf-8")
        inicio = levantar.index("https://$ORQUESTADOR_HOST/health")
        fin = levantar.index('falla "el orquestador no responde por Traefik"')
        chequeo = levantar[levantar.rindex("\n\n", 0, inicio) : fin]
        self.assertIn("for intento in", chequeo)
        self.assertIn("sleep", chequeo)


if __name__ == "__main__":
    unittest.main()
