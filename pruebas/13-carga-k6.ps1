. "$PSScriptRoot\_comun.ps1"

Titulo "Prueba de carga con k6: 5 usuarios a la vez durante 30 s"
if (Faltan-Pdfs-De-Carga) { return }
$desde = Ahora-Utc
# k6-orquestador.js abre los PDFs con una ruta relativa a la carpeta carga.
Push-Location carga
k6 run -e VUS=5 -e DURATION=30s k6-orquestador.js
$codigo = $LASTEXITCODE
Pop-Location
Ver-Reparto $desde
if ($codigo -ne 0) {
    Write-Host ""
    Write-Host "Falló: k6 terminó con código $codigo (algún umbral no se cumplió, ver arriba)." -ForegroundColor Red
    return
}
Resultado "k6 mandó los 10 PDFs de pdfs\ contra POST /pdf durante 30 s, con 5 usuarios a la vez: todas las respuestas fueron 201 o 409, y el reparto entre réplicas está arriba."
DondeVer @(
    'Arriba, en el resumen de k6: checks (100 %), http_reqs (pedidos por segundo), http_req_duration (tiempo total) y tiempo_extraccion_ms (solo la extracción, en los 201)',
    'Los resultados anteriores y la comparación con el profesor: README.md, sección Prueba de carga (k6)'
)
