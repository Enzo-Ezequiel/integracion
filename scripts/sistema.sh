#!/usr/bin/env bash
# Un solo comando para todo lo que se hace con el sistema: levantar las dos capas, correr
# los tests, mostrar el recorrido de un PDF, escanear las imágenes y apagar.
#
# Uso (desde integracion/, en Git Bash): ./scripts/sistema.sh <comando>
# Desde PowerShell:                      .\scripts\sistema.ps1 <comando>
# Requiere los repos clonados al lado de integracion/ (como en el README).
set -euo pipefail

cd "$(dirname "$0")/.."
RAIZ=..
REPOS_PY=(validacion-pdf Extraccion-de-texto-pdf- persistencia-actualizaciones persistencia-consultas Orquestador)

uso() {
  cat >&2 <<'EOF'
Uso: ./scripts/sistema.sh <comando>

  todo      levantar + tests + demo: lo que se muestra en el parcial
  levantar  infraestructura (../dockers) y después los microservicios, con el humo
  tests     suites de los cinco microservicios, de dockers y de integracion
  demo      sube un PDF nuevo y muestra su recorrido: respuesta, logs por correlation_id,
            documento en MongoDB, configuración y tags en Consul, router en Traefik
  grype     escanea las imágenes con Grype (scripts/grype.sh)
  apagar    microservicios y después infraestructura, sin borrar datos
EOF
  exit 2
}

paso() { printf '\n== %s\n' "$1"; }
falla() { echo "ERROR: $1" >&2; exit 1; }
aviso() { echo "aviso: $1" >&2; }
python() { uv run --no-project python "$@"; }

levantar() {
  paso "Infraestructura (primera capa: Consul, Traefik, MongoDB y Redis)"
  docker network inspect redutn >/dev/null 2>&1 || docker network create redutn >/dev/null
  (cd "$RAIZ/dockers" && docker compose up -d --wait)
  ./scripts/levantar.sh
}

tests() {
  local fallos=0 repo d
  for repo in "${REPOS_PY[@]}"; do
    paso "Tests de $repo"
    # python -m pytest: en Windows, Control de aplicaciones bloquea a veces pytest.exe.
    (cd "$RAIZ/$repo" && uv sync -q && uv run python -m pytest -p no:cacheprovider | grep -E "passed|failed|error" | tail -1) ||
      fallos=$((fallos + 1))
  done
  paso "Tests de dockers"
  for d in . consul traefik mongodb redis; do
    [ -d "$RAIZ/dockers/$d/tests" ] || continue
    (cd "$RAIZ/dockers/$d" && python -m unittest discover -s tests -p 'test_*.py' 2>&1 | tail -1) ||
      fallos=$((fallos + 1))
  done
  paso "Tests de integracion"
  (python -m unittest discover -s tests -p 'test_*.py' 2>&1 | tail -1) || fallos=$((fallos + 1))
  [ "$fallos" -eq 0 ] || falla "$fallos suites en rojo"
  echo
  echo "Todas las suites en verde."
}

demo() {
  set -a; source .env; set +a
  local tmp pdf codigo cid id db coleccion
  tmp=$(mktemp -d)
  trap "rm -rf -- '$tmp'" EXIT

  paso "PDF nuevo (contenido único: no da 409)"
  uv run -q scripts/generar_pdfs.py --cantidad 1 --paginas 3 --salida "$tmp" --semilla "demo$(date +%s)" >/dev/null
  pdf=$(ls "$tmp"/*.pdf | head -1)
  echo "$(basename "$pdf"): $(wc -c <"$pdf") bytes, 3 páginas"
  printf '{"archivo_base64":"%s","nombre":"%s"}' "$(base64 -w0 "$pdf")" "$(basename "$pdf")" >"$tmp/body.json"

  paso "POST https://$ORQUESTADOR_HOST/pdf (Traefik → orquestador → validación → extracción → persistencia)"
  codigo=$(curl -k -sS --ssl-no-revoke -o "$tmp/respuesta.json" -D "$tmp/headers.txt" -w '%{http_code}' \
    -X POST "https://$ORQUESTADOR_HOST/pdf" -H "Content-Type: application/json" --data-binary @"$tmp/body.json")
  cid=$(tr -d '\r' <"$tmp/headers.txt" | sed -n 's/^[Xx]-[Cc]orrelation-[Ii][Dd]: //p')
  echo "HTTP $codigo, correlation_id $cid, extracción $(tr -d '\r' <"$tmp/headers.txt" | sed -n 's/^[Xx]-[Ee]xtraction-[Tt]ime-[Mm]s: //p') ms"
  [ "$codigo" = 201 ] || { cat "$tmp/respuesta.json"; echo; falla "se esperaba 201"; }
  # La respuesta sin el texto completo (puede ser largo).
  python -c "import json,sys; d=json.load(open(sys.argv[1], encoding='utf-8')); d['texto']=f'<{len(d[\"texto\"])} caracteres>'; print(json.dumps(d, indent=2, ensure_ascii=False))" "$tmp/respuesta.json"
  id=$(python -c "import json,sys; print(json.load(open(sys.argv[1], encoding='utf-8'))['id'])" "$tmp/respuesta.json")

  paso "Recorrido de la request: líneas de log con correlation_id=$cid"
  docker compose logs --no-color 2>/dev/null | grep "$cid" || aviso "no hay líneas con ese correlation_id"

  db=$(sed -n 's/^MONGO_DATABASE=//p' env/actualizaciones.env | tr -d '\r')
  coleccion=$(sed -n 's/^MONGO_COLLECTION=//p' env/actualizaciones.env | tr -d '\r')
  paso "Documento guardado en MongoDB ($db.$coleccion, sin el texto)"
  MSYS_NO_PATHCONV=1 docker exec mongodb mongosh --quiet "$db" \
    --eval "printjson(db.getCollection('$coleccion').findOne({_id: '$id'}, {texto: 0}))" ||
    aviso "no se pudo consultar MongoDB"

  paso "Consul: claves de configuración (sin valores) y servicios con sus tags"
  # Con el token de interfaz, que queda dentro del volumen de Consul; nunca se muestra.
  MSYS_NO_PATHCONV=1 docker exec consul sh -c \
    'export CONSUL_HTTP_TOKEN=$(cat /consul/data/bootstrap/ui.token); consul kv get -keys -separator= config/ && echo && consul catalog services -tags' ||
    aviso "no se pudo consultar Consul"

  paso "Traefik: router del orquestador, descubierto por Consul Catalog"
  curl -s --ssl-no-revoke "https://traefik.universidad.localhost/api/http/routers/orquestador@consulcatalog" >"$tmp/router.json" &&
    python -c "import json,sys; r=json.load(open(sys.argv[1])); print('regla:', r['rule']); print('middlewares:', ', '.join(r.get('middlewares', []))); print('estado:', r['status'])" "$tmp/router.json" ||
    aviso "no se pudo leer el router en el panel de Traefik"
}

apagar() {
  paso "Microservicios (segunda capa)"
  docker compose down
  paso "Infraestructura (primera capa)"
  (cd "$RAIZ/dockers" && docker compose down)
  echo "Datos de MongoDB y Consul conservados en sus volúmenes."
}

case "${1:-}" in
  todo) levantar; tests; demo ;;
  levantar | tests | demo | apagar) "$1" ;;
  grype) ./scripts/grype.sh ;;
  *) uso ;;
esac
