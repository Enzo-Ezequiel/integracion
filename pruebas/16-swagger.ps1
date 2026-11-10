. "$PSScriptRoot\_comun.ps1"

Titulo "Cargar un PDF a mano desde Swagger"
$pdf = Nuevo-Pdf
$body = '{"archivo_base64": "' + [Convert]::ToBase64String([IO.File]::ReadAllBytes($pdf)) + '", "nombre": "' + (Split-Path $pdf -Leaf) + '"}'
$body | Set-Clipboard
Write-Host "En el portapapeles quedó el body de POST /pdf: un PDF nuevo de 2 páginas en Base64 y su nombre."
Start-Process "https://pdf.universidad.localhost/docs"
Resultado "se abrió el Swagger del orquestador y quedó en el portapapeles el body para cargar un PDF nuevo."
DondeVer @(
    'En Swagger: POST /pdf > Try it out > en el body Ctrl+A y Ctrl+V > Execute: 201 con el documento (texto incluido)',
    'Execute otra vez con el mismo body: 409 DUPLICATE_CHECKSUM',
    'En Response headers: x-correlation-id y x-extraction-time-ms',
    'El pedido en los logs: docker compose logs | Select-String <x-correlation-id de la respuesta>',
    'MongoDB: en Compass, pdfs_db > pdfs y refrescar'
)
