. "$PSScriptRoot\_comun.ps1"

Titulo "Un PDF protegido con contraseña"
# PDF de 1 página protegido con contraseña (AES-256), guardado en el repo.
$archivo = Join-Path $PSScriptRoot "archivos\pdf-con-contrasena.pdf"
Subir $archivo 422
Ver-Pedido
Ver-En-MongoDB
Resultado "se subió un PDF con contraseña y se rechazó con 422 (reason protegido_con_contrasena): no se guardó nada."
DondeVer @(
    'MongoDB, los últimos documentos guardados (sin el texto): docker exec mongodb mongosh pdfs_db --quiet --eval "db.pdfs.find({}, {texto: 0}).sort({created_at: -1}).limit(3)" (no aparece)'
)
