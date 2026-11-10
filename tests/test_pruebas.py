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
    "04-recorrido-de-un-pdf.ps1": "Ver-Pedido",
    "05-pdf-nuevo.ps1": "201",
    "06-pdf-duplicado.ps1": "409",
    "07-no-es-pdf.ps1": "422",
    "08-pdf-con-contrasena.ps1": "422",
    "09-replica-caida.ps1": "extraccion-texto",
    "10-persistencia-caida.ps1": "503",
    "11-redis-caido.ps1": "redis",
    "12-tests.ps1": "tests",
    "13-carga-k6.ps1": "k6 run",
    "14-carga-vegeta.ps1": "run_vegeta.sh",
    "15-grype.ps1": "grype",
    "16-swagger.ps1": "Set-Clipboard",
    "17-apagar.ps1": "apagar",
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

    def test_las_que_suben_pdfs_no_dependen_de_python(self):
        # El Control de aplicaciones de Windows bloquea a veces el python.exe de los
        # entornos temporales de uv: las pruebas de subida no pueden depender de eso.
        for nombre in ["_comun.ps1", *(n for n in SCRIPTS if n[:2] in {"04", "05", "06", "07", "08", "09", "10", "11"})]:
            lineas = (PRUEBAS / nombre).read_text(encoding="utf-8-sig").splitlines()
            codigo = "\n".join(l for l in lineas if not l.lstrip().startswith("#"))
            self.assertNotIn("uv run", codigo, nombre)
            self.assertNotIn("python", codigo.lower(), nombre)

    def test_los_pedidos_https_van_con_curl_exe(self):
        # Invoke-WebRequest/Invoke-RestMethod de Windows PowerShell 5.1 no resuelven
        # *.localhost ("No se puede resolver el nombre remoto"); curl.exe sí.
        for script in [PRUEBAS / "_comun.ps1", *(PRUEBAS / n for n in SCRIPTS)]:
            lineas = script.read_text(encoding="utf-8-sig").splitlines()
            codigo = "\n".join(l for l in lineas if not l.lstrip().startswith("#"))
            self.assertNotIn("Invoke-WebRequest", codigo, script.name)
            self.assertNotIn("Invoke-RestMethod", codigo, script.name)
        self.assertIn("curl.exe", (PRUEBAS / "_comun.ps1").read_text(encoding="utf-8-sig"))
        self.assertIn("curl.exe", (PRUEBAS / "03-traefik.ps1").read_text(encoding="utf-8-sig"))

    def test_el_recorrido_muestra_los_logs_ordenados_por_hora(self):
        # docker compose logs agrupa por contenedor: se ordena por la hora, que va después
        # del "|" de cada línea.
        comun = (PRUEBAS / "_comun.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("function Ver-Pedido", comun)
        self.assertIn("Sort-Object", comun)

    def test_las_que_suben_algo_muestran_los_logs_y_mongodb(self):
        self.assertIn("function Ver-En-MongoDB", (PRUEBAS / "_comun.ps1").read_text(encoding="utf-8-sig"))
        for nombre in SCRIPTS:
            if nombre[:2] in {"04", "05", "06", "07", "08", "09", "10", "11"}:
                texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
                self.assertIn("Ver-Pedido", texto, nombre)
                self.assertIn("Ver-En-MongoDB", texto, nombre)

    def test_el_pdf_con_contrasena_esta_en_el_repo(self):
        protegido = PRUEBAS / "archivos" / "pdf-con-contrasena.pdf"
        self.assertTrue(protegido.read_bytes().startswith(b"%PDF"))
        texto = (PRUEBAS / "08-pdf-con-contrasena.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("pdf-con-contrasena.pdf", texto)

    def test_ninguna_prueba_trae_un_guion_para_decir(self):
        for script in [PRUEBAS / "_comun.ps1", *(PRUEBAS / n for n in SCRIPTS)]:
            texto = script.read_text(encoding="utf-8-sig")
            self.assertNotIn("Decir", texto, script.name)

    def test_cada_prueba_dice_que_paso_y_donde_verlo(self):
        for nombre in SCRIPTS:
            texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
            self.assertIn("Resultado ", texto, nombre)
            self.assertIn("DondeVer ", texto, nombre)

    def test_las_que_usan_sistema_ps1_avisan_si_fallo(self):
        for nombre, esperado in SCRIPTS.items():
            texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
            if "sistema.ps1" in texto:
                self.assertIn("Fallo-Sistema", texto, nombre)

    def test_las_de_carga_avisan_si_faltan_los_pdfs_y_muestran_el_reparto(self):
        # pdfs/ no se versiona: sin los 10 PDFs, k6 y vegeta fallan con un error poco claro.
        # Al final se cuenta cuántos pedidos atendió cada réplica de extracción.
        for nombre in ("13-carga-k6.ps1", "14-carga-vegeta.ps1"):
            texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
            self.assertIn("Faltan-Pdfs-De-Carga", texto, nombre)
            self.assertIn("Ver-Reparto", texto, nombre)
        comun = (PRUEBAS / "_comun.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("function Faltan-Pdfs-De-Carga", comun)
        self.assertIn("function Ver-Reparto", comun)

    def test_swagger_abre_la_pagina_y_deja_el_body_en_el_portapapeles(self):
        # El body entero (PDF nuevo en Base64 y nombre) para pegarlo en POST /pdf.
        texto = (PRUEBAS / "16-swagger.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("Nuevo-Pdf", texto)
        self.assertIn("archivo_base64", texto)
        self.assertIn("https://pdf.universidad.localhost/docs", texto)

    def test_el_pdf_nuevo_se_llama_como_la_prueba_que_lo_sube(self):
        # prueba-05-pdf-nuevo.pdf en vez de prueba-<guid>.pdf: en MongoDB se ve de qué
        # prueba salió cada documento. El GUID sigue en el texto, para que el checksum no se repita.
        comun = (PRUEBAS / "_comun.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("$MyInvocation.PSCommandPath", comun)
        self.assertIn("prueba-$prueba.pdf", comun)
        swagger = (PRUEBAS / "16-swagger.ps1").read_text(encoding="utf-8-sig")
        self.assertNotIn("prueba-swagger.pdf", swagger)

    def test_apagar_borra_los_pdfs_de_las_pruebas_antes_de_apagar(self):
        # Por DELETE /pdf/{id} de persistencia-actualizaciones (el único que escribe), con los
        # servicios todavía prendidos; los documentos con otros nombres quedan.
        texto = (PRUEBAS / "17-apagar.ps1").read_text(encoding="utf-8-sig")
        self.assertIn("prueba-", texto)
        self.assertIn("documento-", texto)
        self.assertIn("method='DELETE'", texto)
        self.assertIn("exec -T persistencia-actualizaciones", texto)
        self.assertLess(texto.index("method='DELETE'"), texto.index("sistema.ps1 apagar"))

    def test_las_pruebas_de_fallas_vuelven_a_levantar_lo_que_apagan(self):
        for nombre in ("09-replica-caida.ps1", "10-persistencia-caida.ps1", "11-redis-caido.ps1"):
            texto = (PRUEBAS / nombre).read_text(encoding="utf-8-sig")
            self.assertIn("up -d --wait", texto, nombre)


if __name__ == "__main__":
    unittest.main()
