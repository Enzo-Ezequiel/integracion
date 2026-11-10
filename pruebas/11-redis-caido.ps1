. "$PSScriptRoot\_comun.ps1"

Titulo "Se cae Redis"
docker stop redis | Out-Null
Subir (Nuevo-Pdf) 201
Ver-Pedido
Ver-En-MongoDB
Titulo "Vuelvo a levantar Redis"
Push-Location $Dockers
docker compose up -d --wait redis
Pop-Location
Resultado "se apagó Redis, el PDF se guardó igual en MongoDB y Redis se volvió a levantar."
DondeVer @(
    'El aviso en los logs: docker compose logs --since 5m persistencia-actualizaciones | Select-String "no disponible"',
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)"'
)
