. "$PSScriptRoot\_comun.ps1"

Titulo "Contenedores corriendo y sus puertos"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
Resultado "arriba está la lista de contenedores con su estado y sus puertos."
DondeVer @(
    'Docker Desktop > Containers: el grupo integracion-pdf (microservicios) y los contenedores de la infraestructura',
    'Solo traefik publica puertos (80 y 443) y consul solo en 127.0.0.1:8500'
)
