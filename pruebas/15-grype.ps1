. "$PSScriptRoot\_comun.ps1"

Titulo "Vulnerabilidades de las imágenes con Grype"
& .\scripts\sistema.ps1 grype
if (Fallo-Sistema) { return }
Resultado "se analizaron con Grype las cinco imágenes del .env."
DondeVer @(
    'El resumen por imagen y severidad: seguridad\resumen.md (en VS Code, Ctrl+Shift+V para verlo como página)'
)
