. "$PSScriptRoot\_comun.ps1"

Titulo "Apagar todo"
& .\scripts\sistema.ps1 apagar
Decir "Se apaga en orden inverso. MongoDB conserva los datos porque tiene volumen; Redis arranca vacío porque es solo caché."
