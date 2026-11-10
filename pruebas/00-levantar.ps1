. "$PSScriptRoot\_comun.ps1"

Titulo "Levantar todo: infraestructura (dockers) y después los cinco microservicios"
& .\scripts\sistema.ps1 levantar
if (Fallo-Sistema) { return }
Resultado "se levantaron la infraestructura (Consul, Traefik, MongoDB y Redis) y los cinco microservicios, con 3 réplicas de extracción."
DondeVer @(
    'Contenedores corriendo: .\pruebas\01-contenedores.ps1, o Docker Desktop > Containers',
    'Consul, servicios registrados y su estado: http://127.0.0.1:8500/ui (el token lo copia .\pruebas\02-consul.ps1)',
    'Traefik, el router del orquestador: https://traefik.universidad.localhost',
    'Swagger del orquestador: https://pdf.universidad.localhost/docs'
)
