. "$PSScriptRoot\_comun.ps1"

Titulo "Un archivo que no es PDF"
$archivo = Join-Path $env:TEMP "no-es-un-pdf.txt"
"Esto es texto, no un PDF." | Set-Content $archivo -Encoding UTF8
Subir $archivo 422
Ver-Pedido
Ver-En-MongoDB
Resultado "se subió un archivo de texto y se rechazó con 422 en validación: no se guardó nada."
DondeVer @(
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)" (no aparece)'
)
