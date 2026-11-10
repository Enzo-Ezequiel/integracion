. "$PSScriptRoot\_comun.ps1"

Titulo "Prueba de carga con vegeta: 30 pedidos por segundo durante 30 s"
if (Faltan-Pdfs-De-Carga) { return }
$desde = Ahora-Utc
# run_vegeta.sh es de bash: se corre con el Git Bash de Git para Windows.
$bash = Join-Path $env:ProgramFiles "Git\bin\bash.exe"
& $bash carga/run_vegeta.sh 30/s 30s a
$codigo = $LASTEXITCODE
Ver-Reparto $desde
if ($codigo -ne 0) {
    Write-Host ""
    Write-Host "Falló: run_vegeta.sh terminó con código $codigo (ver arriba)." -ForegroundColor Red
    return
}
Resultado "vegeta mandó 900 pedidos (30 por segundo durante 30 s) con los 10 PDFs de pdfs\ contra POST /pdf, y el reparto entre réplicas está arriba."
DondeVer @(
    'Arriba, en el reporte de vegeta: Status Codes (201 y 409 son correctos: el 409 es el PDF repetido, que pasa por toda la extracción), Latencies (p50, p95, p99) y Throughput',
    'vegeta cuenta como Success solo los 2xx: con PDFs ya cargados el Success es bajo y está bien',
    'El reporte binario de esta corrida: resultados\vegeta-<fecha>.bin',
    'Los resultados anteriores: README.md, sección Prueba de carga (vegeta)'
)
