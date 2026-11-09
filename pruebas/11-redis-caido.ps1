. "$PSScriptRoot\_comun.ps1"

Titulo "Se cae Redis"
docker stop redis | Out-Null
Subir (Nuevo-Pdf) 201
Titulo "Vuelvo a levantar Redis"
Push-Location $Dockers
docker compose up -d --wait redis
Pop-Location
Decir "Redis es solo caché y lock: si se cae, el sistema sigue contra MongoDB (fail-open). El índice único del checksum evita duplicados aunque no haya lock."
