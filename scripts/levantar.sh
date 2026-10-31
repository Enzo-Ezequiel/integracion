#!/usr/bin/env bash
# Levanta la segunda capa del sistema, los cinco microservicios, sobre la infraestructura
# (primera capa) ya levantada: verifica herramientas y que la infraestructura esté sana,
# crea los .env, construye las imágenes con el tag del .env, levanta los microservicios y
# hace el humo. Con --tests corre además la suite de cada microservicio.
#
# Uso (desde integracion/): ./scripts/levantar.sh [--tests] [--sin-build]
# Requiere los cinco repos clonados al lado de integracion/ y la infraestructura levantada
# antes desde ../dockers con `docker compose up -d --wait`.
set -euo pipefail

cd "$(dirname "$0")/.."
RAIZ=..
CORRER_TESTS=no
CONSTRUIR=si
for arg in "$@"; do
  case "$arg" in
    --tests) CORRER_TESTS=si ;;
    --sin-build) CONSTRUIR=no ;;
    *) echo "Opción desconocida: $arg" >&2; exit 2 ;;
  esac
done

paso() { printf '\n== %s\n' "$1"; }
falla() { echo "ERROR: $1" >&2; exit 1; }

# servicio del compose | carpeta del repo | variable de versión en .env
SERVICIOS=(
  "validacion-pdf|validacion-pdf|VALIDACION_VERSION"
  "extraccion-texto|Extraccion-de-texto-pdf-|EXTRACCION_VERSION"
  "persistencia-actualizaciones|persistencia-actualizaciones|ACTUALIZACIONES_VERSION"
  "persistencia-consultas|persistencia-consultas|CONSULTAS_VERSION"
  "orquestador|Orquestador|ORQUESTADOR_VERSION"
)

paso "Herramientas"
for herramienta in docker uv; do
  command -v "$herramienta" >/dev/null || falla "falta $herramienta"
done
docker compose version >/dev/null || falla "falta docker compose"
docker info >/dev/null 2>&1 || falla "Docker no está corriendo"
command -v k6 >/dev/null && echo "k6: ok" || echo "k6: no instalado (solo hace falta para la carga)"
echo "docker, docker compose y uv: ok"

paso "Repos"
for linea in "${SERVICIOS[@]}"; do
  IFS='|' read -r _ repo _ <<<"$linea"
  [ -d "$RAIZ/$repo" ] || falla "falta el repo $RAIZ/$repo"
  echo "$repo: rama $(git -C "$RAIZ/$repo" branch --show-current)"
done

paso "Infraestructura (primera capa)"
docker network inspect redutn >/dev/null 2>&1 ||
  falla "no existe la red redutn: levantar primero ../dockers (ver README)"
for contenedor in consul mongodb redis; do
  estado=$(docker inspect -f '{{.State.Health.Status}}' "$contenedor" 2>/dev/null || true)
  [ "$estado" = healthy ] || falla "$contenedor no está sano: en ../dockers, docker compose up -d --wait"
done
[ "$(docker inspect -f '{{.State.Running}}' traefik 2>/dev/null)" = true ] ||
  falla "Traefik no corre: en ../dockers, docker compose up -d --wait"
for token in microservices orchestrator; do
  [ -s "$RAIZ/dockers/consul/generated/$token.token" ] ||
    falla "falta el token $token (lo crea el bootstrap de ../dockers)"
done
echo "Consul, Traefik, MongoDB y Redis: ok"

paso "Configuración (.env desde los .env.example que falten)"
[ -f .env ] || cp .env.example .env
for ejemplo in env/*.env.example; do
  [ -f "${ejemplo%.example}" ] || cp "$ejemplo" "${ejemplo%.example}"
done
set -a; source .env; set +a
echo "ok"

if [ "$CONSTRUIR" = si ]; then
  paso "Imágenes"
  for linea in "${SERVICIOS[@]}"; do
    IFS='|' read -r servicio repo variable <<<"$linea"
    imagen="$servicio:${!variable}"
    echo "$imagen  ←  $repo"
    # --pull: siempre la versión actual de la imagen base, con los parches de Debian.
    docker build --pull -q -t "$imagen" "$RAIZ/$repo" >/dev/null
  done
fi

paso "Microservicios (segunda capa)"
docker compose up -d --wait
docker compose ps --format '{{.Name}}  {{.Status}}'

paso "Humo"
for linea in "${SERVICIOS[@]}"; do
  IFS='|' read -r servicio _ _ <<<"$linea"
  codigo=$(docker run --rm --network redutn curlimages/curl -s -o /dev/null -w '%{http_code}' "http://$servicio:8000/health")
  echo "$servicio /health → $codigo"
  [ "$codigo" = 200 ] || falla "$servicio no responde"
done
codigo=$(curl -s --ssl-no-revoke -o /dev/null -w '%{http_code}' "https://$ORQUESTADOR_HOST/health" || true)
echo "https://$ORQUESTADOR_HOST/health (Traefik) → $codigo"
[ "$codigo" = 200 ] || falla "el orquestador no responde por Traefik"

if [ "$CORRER_TESTS" = si ]; then
  paso "Tests de cada microservicio"
  for linea in "${SERVICIOS[@]}"; do
    IFS='|' read -r _ repo _ <<<"$linea"
    echo "-- $repo"
    # python -m pytest: en Windows, Control de aplicaciones bloquea a veces pytest.exe.
    (cd "$RAIZ/$repo" && uv sync -q && uv run python -m pytest -p no:cacheprovider | grep -E "passed|failed" | tail -1)
  done
fi

paso "Listo: https://$ORQUESTADOR_HOST"
