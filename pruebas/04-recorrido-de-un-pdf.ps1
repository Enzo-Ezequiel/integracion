. "$PSScriptRoot\_comun.ps1"

Titulo "Recorrido completo de un PDF nuevo"
Subir (Nuevo-Pdf) 201
if (-not $global:UltimoId) {
    Write-Host ""
    Write-Host "Falló: el PDF no se guardó (ver la línea HTTP de arriba)." -ForegroundColor Red
    return
}

Ver-Pedido
Ver-En-MongoDB

Resultado "se subió un PDF nuevo, se mostró su recorrido por los cinco servicios en los logs y el documento guardado en MongoDB."
DondeVer @(
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)"',
    'Todos los logs: docker compose logs, desde la carpeta integracion',
    'Swagger del orquestador: https://pdf.universidad.localhost/docs'
)
