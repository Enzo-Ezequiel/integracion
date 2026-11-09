. "$PSScriptRoot\_comun.ps1"

Titulo "Un archivo que no es PDF"
$archivo = Join-Path $env:TEMP "no-es-un-pdf.txt"
"Esto es texto, no un PDF." | Set-Content $archivo -Encoding UTF8
Subir $archivo 422
Decir "Validación revisa la firma %PDF: responde 422 PDF_INVALID y no se llama a extracción ni a persistencia."
