. "$PSScriptRoot\_comun.ps1"

Titulo "Se cae persistencia-actualizaciones"
docker compose stop persistencia-actualizaciones
Start-Sleep -Seconds 5
Subir (Nuevo-Pdf) 503
Titulo "Vuelvo a levantar persistencia-actualizaciones"
docker compose up -d --wait persistencia-actualizaciones
Decir "Si una dependencia no está, el orquestador responde 503 DEPENDENCY_UNAVAILABLE y no 500. Si el alta hubiera quedado en duda (timeout), la SAGA busca el documento por checksum y lo borra."
