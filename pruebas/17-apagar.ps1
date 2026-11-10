. "$PSScriptRoot\_comun.ps1"

Titulo "Borrar los PDFs que subieron las pruebas"
# prueba-*.pdf (04 a 11 y Swagger) y documento-<semilla>-NN.pdf (k6 y vegeta). Los demás quedan.
$ids = @(docker exec mongodb mongosh pdfs_db --quiet --eval 'db.pdfs.find({nombre: /^(prueba-.*|documento-\w+-\d+)\.pdf$/}, {_id: 1}).forEach(d => print(d._id))')
if ($LASTEXITCODE -ne 0) {
    Write-Host "No se pudo leer MongoDB: no se borró nada." -ForegroundColor Red
} elseif ($ids.Count -eq 0) {
    Write-Host "No hay PDFs de prueba para borrar."
} else {
    # DELETE /pdf/{id} desde adentro de persistencia-actualizaciones, el único servicio que
    # escribe en la colección: así también invalida la caché. Un 404 es que ya estaba borrado.
    $borrar = @'
import sys, urllib.error, urllib.request
borrados = 0
for doc_id in sys.argv[1:]:
    try:
        urllib.request.urlopen(urllib.request.Request('http://127.0.0.1:8000/pdf/' + doc_id, method='DELETE'), timeout=10)
        borrados += 1
    except urllib.error.HTTPError as error:
        if error.code != 404:
            print('No se pudo borrar', doc_id, '- HTTP', error.code)
print('Documentos borrados:', borrados, 'de', len(sys.argv) - 1)
'@
    $borrar | docker compose exec -T persistencia-actualizaciones python - $ids
}

Titulo "Apagar todo"
& .\scripts\sistema.ps1 apagar
if (Fallo-Sistema) { return }
Resultado "se borraron los PDFs de las pruebas y se apagaron los microservicios y la infraestructura. Los demás documentos siguen en el volumen de MongoDB."
DondeVer @(
    'Docker Desktop > Containers: todo en Exited',
    'El volumen con los datos: docker volume ls (proyecto-mongo-data)',
    'Para volver a prender todo: .\pruebas\00-levantar.ps1'
)
