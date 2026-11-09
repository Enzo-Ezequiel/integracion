. "$PSScriptRoot\_comun.ps1"

Titulo "El mismo PDF dos veces"
$pdf = Nuevo-Pdf
Subir $pdf 201
Subir $pdf 409
Decir "El checksum tiene índice único en MongoDB: la segunda vez responde 409 DUPLICATE_CHECKSUM y no se guarda dos veces."
