"""pruebas/: un script de PowerShell por cada cosa que se muestra del sistema, para correr
de a uno con el botón ▷ de VS Code. Cada uno dice qué hace y qué se espera."""

import unittest
from pathlib import Path

PRUEBAS = Path(__file__).resolve().parents[1] / "pruebas"
SCRIPTS = {
    "00-levantar.ps1": "sistema.ps1",
    "01-contenedores.ps1": "docker ps",
    "02-consul.ps1": "Set-Clipboard",
    "03-traefik.ps1": "orquestador@consulcatalog",
    "04-recorrido-de-un-pdf.ps1": "demo",
    "05-pdf-nuevo.ps1": "201",
    "06-pdf-duplicado.ps1": "409",
    "07-no-es-pdf.ps1": "422",
    "08-pdf-con-contrasena.ps1": "422",
    "09-replica-caida.ps1": "extraccion-texto",
    "10-persistencia-caida.ps1": "503",
    "11-redis-caido.ps1": "redis",
    "12-tests.ps1": "tests",
    "13-grype.ps1": "grype",
    "14-apagar.ps1": "apagar",
}


class PruebasTests(unittest.TestCase):
    def test_hay_un_script_por_prueba_y_cada_uno_hace_lo_suyo(self):
        for nombre, esperado in SCRIPTS.items():
            texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
            self.assertIn('. "$PSScriptRoot\_comun.ps1"', texto, nombre)
            self.assertIn(esperado, texto, nombre)

    def test_tienen_bom_para_que_powershell_5_lea_bien_los_acentos(self):
        for script in [PRUEBAS / "_comun.ps1", *(PRUEBAS / n for n in SCRIPTS)]:
            self.assertTrue(
                script.read_bytes().startswith(b"\xef\xbb\xbf"), script.name
            )

    def test_el_token_de_consul_nunca_se_muestra(self):
        consul = (PRUEBAS / "02-consul.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("ui.token | Set-Clipboard", consul)
        self.assertNotIn("Write-Host $token", consul)

    def test_las_pruebas_de_fallas_vuelven_a_levantar_lo_que_apagan(self):
        for nombre in ("09-replica-caida.ps1", "10-persistencia-caida.ps1", "11-redis-caido.ps1"):
            texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
            self.assertIn("up -d --wait", texto, nombre)


if __name__ == "__main__":
    unittest.main()
