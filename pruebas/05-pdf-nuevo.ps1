. "$PSScriptRoot\_comun.ps1"

Titulo "Un PDF nuevo se guarda"
Subir (Nuevo-Pdf) 201
Ver-Pedido
Ver-En-MongoDB
Resultado "se subió un PDF nuevo y quedó guardado en MongoDB (arriba, el documento y su recorrido en los logs)."
DondeVer @(
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)"',
    'Swagger del orquestador: https://pdf.universidad.localhost/docs'
)
