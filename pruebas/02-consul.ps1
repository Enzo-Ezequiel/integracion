. "$PSScriptRoot\_comun.ps1"

Titulo "Consul: servicios registrados y su configuración"
# El token de la interfaz va directo al portapapeles: nunca se muestra en pantalla.
docker exec consul cat /consul/data/bootstrap/ui.token | Set-Clipboard
Write-Host "Token de la interfaz copiado al portapapeles: pegalo con Ctrl+V en la página que se abre."
Start-Process "http://127.0.0.1:8500/ui/"
Write-Host ""
docker exec consul sh -c 'export CONSUL_HTTP_TOKEN=$(cat /consul/data/bootstrap/ui.token); consul catalog services'
Decir "Consul es la guía de servicios: cada uno se registra al arrancar y Consul revisa su /health. También guarda la configuración de cada servicio (Key/Value, config/). Tiene ACL: sin token no se ve nada."
