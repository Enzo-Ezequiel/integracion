. "$PSScriptRoot\_comun.ps1"

Titulo "Tests de los siete repos"
& .\scripts\sistema.ps1 tests
if (Fallo-Sistema) { return }
Resultado "se corrieron las suites de tests de los repos (arriba, una línea por repo)."
DondeVer @(
    'En cada repo, la suite completa: uv run python -m pytest',
    'El historial de TDD (test antes que feat): git log --oneline, en cada repo'
)
