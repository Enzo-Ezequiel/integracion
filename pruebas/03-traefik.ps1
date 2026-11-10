. "$PSScriptRoot\_comun.ps1"

Titulo "Traefik: el router del orquestador lo descubre Consul"
# curl.exe y no Invoke-RestMethod: Windows PowerShell 5.1 no resuelve *.localhost.
$respuesta = curl.exe -s --ssl-no-revoke "https://traefik.universidad.localhost/api/http/routers/orquestador@consulcatalog"
if ($LASTEXITCODE -ne 0 -or -not $respuesta) {
    Write-Host ""
    Write-Host "Falló: la API de Traefik no respondió (curl.exe terminó con código $LASTEXITCODE)." -ForegroundColor Red
    return
}
$router = ($respuesta -join "`n") | ConvertFrom-Json
Write-Host "regla:       $($router.rule)"
Write-Host "middlewares: $($router.middlewares -join ', ')"
Write-Host "estado:      $($router.status)"
Start-Process "https://traefik.universidad.localhost"
Resultado "se leyó de la API de Traefik el router del orquestador (arriba) y se abrió el panel."
DondeVer @(
    'En el panel de Traefik: HTTP > Routers > orquestador@consulcatalog, con sus middlewares',
    'Es el único router de la API: los demás servicios no están publicados'
)
