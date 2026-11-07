# Para correr desde PowerShell: .\scripts\sistema.ps1 todo
# Llama a scripts/sistema.sh con Git Bash, con los mismos comandos (ver sistema.sh).
$bash = Join-Path $env:ProgramFiles "Git\bin\bash.exe"
if (-not (Test-Path $bash)) {
    Write-Error "Falta Git Bash ($bash): instalar Git para Windows."
    exit 1
}
& $bash (Join-Path $PSScriptRoot "sistema.sh") @args
exit $LASTEXITCODE
