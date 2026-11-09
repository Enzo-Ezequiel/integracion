. "$PSScriptRoot\_comun.ps1"

Titulo "Traefik: el router del orquestador lo descubre Consul"
$router = Invoke-RestMethod "https://traefik.universidad.localhost/api/http/routers/orquestador@consulcatalog"
Write-Host "regla:       $($router.rule)"
Write-Host "middlewares: $($router.middlewares -join ', ')"
Write-Host "estado:      $($router.status)"
Start-Process "https://traefik.universidad.localhost"
Decir "Traefik es la puerta de entrada por HTTPS. Su proveedor es Consul Catalog: publica solo al orquestador, con el cortocircuito y el límite de pedidos. No tiene acceso a Docker (le sacamos el docker.sock)."
