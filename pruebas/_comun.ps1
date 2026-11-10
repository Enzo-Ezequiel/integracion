# Funciones comunes de las pruebas. Cada script las carga con: . "$PSScriptRoot\_comun.ps1"
# Se corren de a uno con el botón ▷ de VS Code (o .\pruebas\05-pdf-nuevo.ps1).

$Integracion = Split-Path $PSScriptRoot -Parent
$Dockers = Join-Path (Split-Path $Integracion -Parent) "dockers"
Set-Location $Integracion
[Console]::OutputEncoding = [Text.Encoding]::UTF8
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Url = "https://pdf.universidad.localhost/pdf"

function Titulo($texto) {
    Write-Host ""
    Write-Host "== $texto" -ForegroundColor Cyan
}

function Resultado($texto) {
    Write-Host ""
    Write-Host "Resultado: $texto" -ForegroundColor Green
}

function DondeVer([string[]]$lugares) {
    Write-Host "Dónde verlo:"
    foreach ($lugar in $lugares) { Write-Host "  - $lugar" }
}

function Fallo-Sistema {
    # sistema.ps1 termina con el código de salida de sistema.sh: distinto de 0 si algo falló.
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "Falló: revisá la línea ERROR de arriba." -ForegroundColor Red
        return $true
    }
    return $false
}

function Nuevo-Pdf {
    # Un PDF de 2 páginas con un texto único (un GUID), para que no dé 409. Se arma acá mismo
    # y no con Python: el Control de aplicaciones de Windows bloquea a veces el python.exe de
    # los entornos temporales de uv. Devuelve la ruta.
    # Se llama como la prueba que lo pide (prueba-05-pdf-nuevo.pdf); el GUID va en el texto.
    $prueba = if ($MyInvocation.PSCommandPath) { [IO.Path]::GetFileNameWithoutExtension($MyInvocation.PSCommandPath) } else { "manual" }
    $marca = [guid]::NewGuid().ToString()
    $objetos = @(
        '<< /Type /Catalog /Pages 2 0 R >>',
        '<< /Type /Pages /Kids [3 0 R 4 0 R] /Count 2 >>'
    )
    foreach ($n in 1..2) {
        $objetos += "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents $(4 + $n) 0 R /Resources << /Font << /F1 7 0 R >> >> >>"
    }
    foreach ($n in 1..2) {
        $texto = "BT /F1 14 Tf 72 720 Td (Prueba $prueba - $marca - pagina $n) Tj ET"
        $objetos += "<< /Length $($texto.Length) >>`nstream`n$texto`nendstream"
    }
    $objetos += '<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>'
    $pdf = "%PDF-1.4`n"
    $posiciones = @()
    for ($i = 0; $i -lt $objetos.Count; $i++) {
        $posiciones += $pdf.Length
        $pdf += "$($i + 1) 0 obj`n$($objetos[$i])`nendobj`n"
    }
    $xref = $pdf.Length
    $pdf += "xref`n0 $($objetos.Count + 1)`n0000000000 65535 f `n"
    foreach ($p in $posiciones) { $pdf += ("{0:D10} 00000 n `n" -f $p) }
    $pdf += "trailer`n<< /Size $($objetos.Count + 1) /Root 1 0 R >>`nstartxref`n$xref`n%%EOF`n"
    # Una carpeta por PDF: el nombre se repite entre corridas, el archivo no se pisa.
    $carpeta = Join-Path $env:TEMP "pdf-$marca"
    New-Item -ItemType Directory $carpeta | Out-Null
    $ruta = Join-Path $carpeta "prueba-$prueba.pdf"
    [IO.File]::WriteAllBytes($ruta, [Text.Encoding]::ASCII.GetBytes($pdf))
    $ruta
}

function Subir($archivo, $esperado) {
    # POST /pdf al orquestador (por Traefik) y muestra el resultado contra lo esperado.
    # Con curl.exe: Invoke-WebRequest de Windows PowerShell 5.1 no resuelve *.localhost.
    # --ssl-no-revoke: el curl de Windows exige comprobar la revocación y los certificados
    # de mkcert no la publican (la cadena y el nombre se validan igual).
    # Deja en $global:UltimoCid, $global:UltimoId y $global:UltimoChecksum el correlation_id,
    # el id del documento (si se guardó) y su checksum (si se guardó o era un duplicado).
    $global:UltimoCid = $null
    $global:UltimoId = $null
    $global:UltimoChecksum = $null
    $nombre = Split-Path $archivo -Leaf
    $tmp = Join-Path $env:TEMP ("subir-" + [guid]::NewGuid())
    New-Item -ItemType Directory $tmp | Out-Null
    $json = '{"archivo_base64":"' + [Convert]::ToBase64String([IO.File]::ReadAllBytes($archivo)) + '","nombre":"' + $nombre + '"}'
    [IO.File]::WriteAllText("$tmp\body.json", $json)
    Write-Host "POST $Url  ($nombre, se espera HTTP $esperado)"
    $codigo = curl.exe -s --ssl-no-revoke -o "$tmp\respuesta.json" -D "$tmp\headers.txt" -w "%{http_code}" -X POST $Url -H "Content-Type: application/json" --data-binary "@$tmp\body.json"
    if ($LASTEXITCODE -ne 0 -or $codigo -eq "000") {
        Write-Host "No hubo respuesta de $Url (curl.exe terminó con código $LASTEXITCODE)" -ForegroundColor Red
        Remove-Item $tmp -Recurse -ErrorAction SilentlyContinue
        return
    }
    $codigo = [int]$codigo
    $cid = $null
    foreach ($linea in Get-Content "$tmp\headers.txt") {
        if ($linea -match '^x-correlation-id:\s*(\S+)') { $cid = $Matches[1] }
    }
    $respuesta = [IO.File]::ReadAllText("$tmp\respuesta.json") | ConvertFrom-Json
    Remove-Item $tmp -Recurse -ErrorAction SilentlyContinue
    if ($respuesta.error) {
        $detalle = "$($respuesta.error.code)  details=$($respuesta.error.details | ConvertTo-Json -Compress)"
        if ($respuesta.error.details.checksum) { $global:UltimoChecksum = $respuesta.error.details.checksum }
    } else {
        $detalle = "id=$($respuesta.id) paginas=$($respuesta.paginas) checksum=$($respuesta.checksum.Substring(0, 12))..."
        $global:UltimoId = $respuesta.id
        $global:UltimoChecksum = $respuesta.checksum
    }
    $color = if ($codigo -eq $esperado) { "Green" } else { "Red" }
    Write-Host "HTTP $codigo  $detalle" -ForegroundColor $color
    Write-Host "correlation_id=$cid"
    if ($codigo -ne $esperado) { Write-Host "MAL: se esperaba HTTP $esperado" -ForegroundColor Red }
    $global:UltimoCid = $cid
}

function Ver-Pedido {
    # Las líneas de log del último pedido en todos los servicios, ordenadas por hora:
    # docker compose logs agrupa por contenedor, y la hora va después del "|" de cada línea.
    if (-not $global:UltimoCid) { return }
    Titulo "Ese pedido en los logs (correlation_id=$global:UltimoCid)"
    Start-Sleep -Seconds 1
    docker compose logs --no-color 2>$null | Select-String $global:UltimoCid | ForEach-Object { $_.Line } |
        Sort-Object { ($_ -split '\|', 2)[1] }
}

function Ver-En-MongoDB {
    # Qué quedó en MongoDB después del último pedido.
    Titulo "En MongoDB"
    if ($global:UltimoId) {
        Write-Host "Documento guardado (sin el texto):"
        docker exec mongodb mongosh pdfs_db --quiet --eval "printjson(db.pdfs.findOne({_id: '$global:UltimoId'}, {texto: 0}))"
    } elseif ($global:UltimoChecksum) {
        docker exec mongodb mongosh pdfs_db --quiet --eval "print('Documentos con ese checksum: ' + db.pdfs.countDocuments({checksum: '$global:UltimoChecksum'}))"
    } elseif ($global:UltimoCid) {
        Write-Host "No se guardó ningún documento."
    } else {
        Write-Host "No hubo respuesta: no hay nada que buscar."
    }
}

function Faltan-Pdfs-De-Carga {
    # pdfs\ no está en git: son los 10 PDFs del escenario del profesor (semilla a).
    if (Test-Path (Join-Path $Integracion "pdfs\documento-a-10.pdf")) { return $false }
    Write-Host ""
    Write-Host "Faltan los 10 PDFs de carga en pdfs\. Se generan con scripts\generar_pdfs.py (ver su encabezado: 10 PDFs, 10 páginas, semilla a)." -ForegroundColor Red
    return $true
}

function Ver-Reparto($desde) {
    # Cuántos pedidos de extracción atendió cada réplica desde $desde: el reparto que hace
    # traefik-interno. Cada línea de log empieza con el nombre del contenedor y un "|".
    Titulo "Pedidos que atendió cada réplica de extracción"
    docker compose logs --no-color --since $desde extraccion-texto 2>$null | Select-String "path=/extraer status=" |
        ForEach-Object { ($_.Line -split '\|', 2)[0].Trim() } | Group-Object | Sort-Object Name |
        ForEach-Object { "{0,-22} {1}" -f $_.Name, $_.Count }
}

function Ahora-Utc {
    # Marca de tiempo para docker compose logs --since.
    (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}
