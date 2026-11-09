. "$PSScriptRoot\_comun.ps1"

Titulo "Tests de los siete repos"
& .\scripts\sistema.ps1 tests
Decir "Cada microservicio tiene tests unitarios y de integración, hechos con TDD: en el historial están los commits rojos antes de los verdes. No hace falta nada levantado: usan dobles en memoria."
