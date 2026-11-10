. "$PSScriptRoot\_comun.ps1"

Titulo "Se cae una réplica de extracción"
$replica = docker compose ps -q extraccion-texto | Select-Object -First 1
docker stop $replica | Out-Null
Write-Host "Réplica detenida. Quedan:"
docker compose ps extraccion-texto --format "table {{.Name}}\t{{.Status}}"
Start-Sleep -Seconds 3
Subir (Nuevo-Pdf) 201
Ver-Pedido
Ver-En-MongoDB
Titulo "Vuelvo a levantar la réplica"
docker compose up -d --wait extraccion-texto
Resultado "se apagó una réplica de extracción, el PDF se guardó igual con las otras dos y la réplica se volvió a levantar."
DondeVer @(
    'Consul > extraccion: ahora las 3 instancias en verde',
    'Para verla caída en Consul: docker stop integracion-pdf-extraccion-texto-1, mirar Consul y después docker start integracion-pdf-extraccion-texto-1',
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)"'
)
