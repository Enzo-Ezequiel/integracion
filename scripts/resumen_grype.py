"""Resume los reportes JSON de Grype (seguridad/*.grype.json) en seguridad/resumen.md.

Uso: python scripts/resumen_grype.py
"""

import json
from collections import Counter
from datetime import date
from pathlib import Path

SEVERIDADES = ["Critical", "High", "Medium", "Low", "Negligible", "Unknown"]
CARPETA = Path("seguridad")


def leer(reporte: Path) -> tuple[str, list[dict]]:
    datos = json.loads(reporte.read_text(encoding="utf-8"))
    imagen = datos["source"]["target"]["userInput"]
    return imagen, datos["matches"]


def fila_resumen(imagen: str, matches: list[dict]) -> str:
    por_severidad = Counter(m["vulnerability"]["severity"] for m in matches)
    con_arreglo = sum(1 for m in matches if m["vulnerability"]["fix"]["state"] == "fixed")
    python = sum(1 for m in matches if m["artifact"]["type"] == "python")
    celdas = [str(por_severidad.get(s, 0)) for s in SEVERIDADES]
    return f"| `{imagen}` | {' | '.join(celdas)} | {len(matches)} | {con_arreglo} | {python} |"


def graves(imagen: str, matches: list[dict]) -> list[str]:
    filas = []
    for m in matches:
        vuln, artefacto = m["vulnerability"], m["artifact"]
        if vuln["severity"] not in ("Critical", "High"):
            continue
        arreglo = ", ".join(vuln["fix"]["versions"]) or "sin arreglo"
        filas.append(
            f"| `{imagen}` | {vuln['severity']} | {vuln['id']} | `{artefacto['name']}` "
            f"{artefacto['version']} ({artefacto['type']}) | {arreglo} |"
        )
    return sorted(set(filas))


def main() -> None:
    reportes = [leer(r) for r in sorted(CARPETA.glob("*.grype.json"))]
    lineas = [
        "# Resumen de Grype",
        "",
        f"Generado el {date.today().isoformat()} con `scripts/grype.sh`.",
        "",
        f"| Imagen | {' | '.join(SEVERIDADES)} | Total | Con arreglo | De Python |",
        "|---|" + "---|" * (len(SEVERIDADES) + 3),
    ]
    lineas += [fila_resumen(imagen, matches) for imagen, matches in reportes]
    lineas += [
        "",
        "## Critical y High",
        "",
        "| Imagen | Severidad | Vulnerabilidad | Paquete | Versión con arreglo |",
        "|---|---|---|---|---|",
    ]
    for imagen, matches in reportes:
        lineas += graves(imagen, matches)
    (CARPETA / "resumen.md").write_text("\n".join(lineas) + "\n", encoding="utf-8")
    print("\n".join(lineas[:6 + len(reportes)]))


if __name__ == "__main__":
    main()
