. "$PSScriptRoot\_comun.ps1"

Titulo "Levantar todo: infraestructura (dockers) y después los cinco microservicios"
& .\scripts\sistema.ps1 levantar
Decir "Son dos docker compose en orden: primero Consul, Traefik, MongoDB y Redis; después los microservicios, que se registran solos en Consul."
