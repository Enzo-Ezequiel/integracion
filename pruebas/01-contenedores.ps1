. "$PSScriptRoot\_comun.ps1"

Titulo "Contenedores corriendo y sus puertos"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
Decir "Dos capas: la infraestructura y los cinco microservicios, con tres réplicas de extracción. Solo Traefik publica puertos (80 y 443); el resto está en la red interna redutn y se llama por nombre."
