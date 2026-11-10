. "$PSScriptRoot\_comun.ps1"

Titulo "Se cae persistencia-actualizaciones"
docker compose stop persistencia-actualizaciones
Start-Sleep -Seconds 5
Subir (Nuevo-Pdf) 503
Ver-Pedido
Ver-En-MongoDB
Titulo "Vuelvo a levantar persistencia-actualizaciones"
docker compose up -d --wait persistencia-actualizaciones
Resultado "se apagó persistencia-actualizaciones, el alta respondió 503 sin guardar nada y el servicio se volvió a levantar."
DondeVer @(
    'La compensación SAGA en los logs del orquestador: docker compose logs --since 5m orquestador | Select-String SAGA',
    'Consul > persistencia-actualizaciones: de nuevo en verde',
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)" (el PDF de esta prueba no aparece)'
)
