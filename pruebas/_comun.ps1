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

function Decir($texto) {
    Write-Host ""
    Write-Host "Para decir: $texto" -ForegroundColor Yellow
}

function Nuevo-Pdf {
    # Un PDF de 2 páginas con contenido único, para que no dé 409. Devuelve la ruta.
    $carpeta = Join-Path $env:TEMP ("prueba-" + [guid]::NewGuid())
    uv run -q scripts/generar_pdfs.py --cantidad 1 --paginas 2 --salida $carpeta --semilla ([guid]::NewGuid()) | Out-Null
    (Get-ChildItem $carpeta -Filter *.pdf | Select-Object -First 1).FullName
}

function Subir($archivo, $esperado) {
    # POST /pdf al orquestador (por Traefik) y muestra el resultado contra lo esperado.
    $body = @{
        archivo_base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($archivo))
        nombre = Split-Path $archivo -Leaf
    } | ConvertTo-Json
    Write-Host "POST $Url  ($(Split-Path $archivo -Leaf), se espera HTTP $esperado)"
    try {
        $r = Invoke-WebRequest -UseBasicParsing -Method Post -Uri $Url -ContentType "application/json" -Body $body
        $codigo = [int]$r.StatusCode
        $cid = $r.Headers["X-Correlation-ID"]
        $doc = $r.Content | ConvertFrom-Json
        $detalle = "id=$($doc.id) paginas=$($doc.paginas) checksum=$($doc.checksum.Substring(0, 12))..."
    } catch [System.Net.WebException] {
        $respuesta = $_.Exception.Response
        if (-not $respuesta) { Write-Host "No hubo respuesta: $($_.Exception.Message)" -ForegroundColor Red; return }
        $codigo = [int]$respuesta.StatusCode
        $cid = $respuesta.Headers["X-Correlation-ID"]
        $err = ($_.ErrorDetails.Message | ConvertFrom-Json).error
        $detalle = "$($err.code)  details=$($err.details | ConvertTo-Json -Compress)"
    }
    $color = if ($codigo -eq $esperado) { "Green" } else { "Red" }
    Write-Host "HTTP $codigo  $detalle" -ForegroundColor $color
    Write-Host "correlation_id=$cid"
    if ($codigo -ne $esperado) { Write-Host "MAL: se esperaba HTTP $esperado" -ForegroundColor Red }
}
