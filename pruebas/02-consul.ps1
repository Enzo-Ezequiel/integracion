. "$PSScriptRoot\_comun.ps1"

Titulo "Consul: servicios registrados y su configuración"
# El token de la interfaz va directo al portapapeles: nunca se muestra en pantalla.
docker exec consul cat /consul/data/bootstrap/ui.token | Set-Clipboard
Write-Host "Token de la interfaz copiado al portapapeles: pegalo con Ctrl+V en la página que se abre."
Start-Process "http://127.0.0.1:8500/ui/"
Write-Host ""
docker exec consul sh -c 'export CONSUL_HTTP_TOKEN=$(cat /consul/data/bootstrap/ui.token); consul catalog services'
Resultado "se copió el token de la interfaz al portapapeles y se abrió Consul en el navegador."
DondeVer @(
    'En la página de Consul: Log in (arriba a la derecha), pegar con Ctrl+V',
    'Services: validacion-pdf, extraccion (3 instancias), persistencia-actualizaciones, persistencia-consultas y orquestador, en verde',
    'Key/Value > config: la configuración de cada servicio'
)
