. "$PSScriptRoot\_comun.ps1"

Titulo "Un PDF protegido con contraseña"
$archivo = Join-Path $env:TEMP "protegido.pdf"
uv run -q --no-project --with pymupdf python -c "import pymupdf, sys; d=pymupdf.open(); d.new_page(); d.save(sys.argv[1], encryption=pymupdf.PDF_ENCRYPT_AES_256, user_pw='1234', owner_pw='x')" $archivo
Subir $archivo 422
Decir "Lo preguntó el profesor: validación lo abre con PyMuPDF y needs_pass dice que pide contraseña. Responde 422 PDF_INVALID con reason protegido_con_contrasena (antes daba 500)."
