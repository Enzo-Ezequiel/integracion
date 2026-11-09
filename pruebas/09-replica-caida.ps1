. "$PSScriptRoot\_comun.ps1"

Titulo "Se cae una réplica de extracción"
$replica = docker compose ps -q extraccion-texto | Select-Object -First 1
docker stop $replica | Out-Null
Write-Host "Réplica detenida. Quedan:"
docker compose ps extraccion-texto --format "table {{.Name}}\t{{.Status}}"
Start-Sleep -Seconds 3
Subir (Nuevo-Pdf) 201
Titulo "Vuelvo a levantar la réplica"
docker compose up -d --wait extraccion-texto
Decir "Al apagarse, la réplica se da de baja de Consul; el orquestador usa las otras dos y el pedido sigue andando."
