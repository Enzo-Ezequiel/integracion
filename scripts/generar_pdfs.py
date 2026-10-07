# /// script
# requires-python = ">=3.10"
# dependencies = ["reportlab"]
# ///
"""Genera PDFs de prueba con texto extraíble y varias páginas.

Cada archivo tiene contenido distinto (y por lo tanto checksum distinto). La semilla
cambia el contenido de toda la tanda: sirve para repetir una prueba sin chocar con
los 409 DUPLICATE_CHECKSUM de la tanda anterior.

Uso: uv run scripts/generar_pdfs.py --cantidad 10 --paginas 10 --salida pdfs --semilla a
"""

import argparse
from pathlib import Path

from reportlab.lib.pagesizes import A4
from reportlab.pdfgen import canvas

PARRAFO = (
    "Los microservicios del contrato microservicios-pdf validan, extraen y persisten "
    "documentos. Cada servicio hace una sola cosa y se comunica por HTTP con JSON."
)


def generar(destino: Path, numero: int, paginas: int, semilla: str) -> None:
    pdf = canvas.Canvas(str(destino), pagesize=A4)
    _, alto = A4
    for pagina in range(1, paginas + 1):
        y = alto - 60
        pdf.setFont("Helvetica-Bold", 14)
        pdf.drawString(50, y, f"Documento {numero} - tanda {semilla} - pagina {pagina}")
        pdf.setFont("Helvetica", 10)
        for linea in range(1, 45):
            y -= 16
            pdf.drawString(50, y, f"{linea:02d}. {PARRAFO[: 60 + (linea * numero) % 40]}")
        pdf.showPage()
    pdf.save()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cantidad", type=int, default=10)
    parser.add_argument("--paginas", type=int, default=10)
    parser.add_argument("--salida", type=Path, default=Path("pdfs"))
    parser.add_argument("--semilla", default="a")
    args = parser.parse_args()

    args.salida.mkdir(parents=True, exist_ok=True)
    for numero in range(1, args.cantidad + 1):
        destino = args.salida / f"documento-{args.semilla}-{numero:02d}.pdf"
        generar(destino, numero, args.paginas, args.semilla)
        print(destino)


if __name__ == "__main__":
    main()
