. "$PSScriptRoot\_comun.ps1"

Titulo "Vulnerabilidades de las imágenes con Grype"
& .\scripts\sistema.ps1 grype
Decir "Grype escanea las cinco imágenes y deja el resumen en seguridad/resumen.md."
