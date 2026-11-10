. "$PSScriptRoot\_comun.ps1"

Titulo "El mismo PDF dos veces"
$pdf = Nuevo-Pdf
Subir $pdf 201
Subir $pdf 409
Ver-Pedido
Ver-En-MongoDB
Resultado "se subió el mismo PDF dos veces: la primera se guardó y la segunda se rechazó con 409 (en MongoDB hay un solo documento con ese checksum)."
DondeVer @(
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)" (aparece una sola vez)'
)
