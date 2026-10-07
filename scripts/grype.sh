#!/usr/bin/env bash
# Escanea con Grype las imágenes del .env y resume el resultado en seguridad/resumen.md.
# Grype corre como contenedor (anchore/grype); su base de vulnerabilidades queda en el
# volumen grype-db para no descargarla en cada corrida.
#
# Uso (desde integracion/): ./scripts/grype.sh
set -euo pipefail

cd "$(dirname "$0")/.."
set -a; source .env; set +a
mkdir -p seguridad

IMAGENES=(
  "validacion-pdf:$VALIDACION_VERSION"
  "extraccion-texto:$EXTRACCION_VERSION"
  "persistencia-actualizaciones:$ACTUALIZACIONES_VERSION"
  "persistencia-consultas:$CONSULTAS_VERSION"
  "orquestador:$ORQUESTADOR_VERSION"
)

grype() {
  MSYS_NO_PATHCONV=1 docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v grype-db:/root/.cache/grype \
    anchore/grype:latest "$@"
}

grype db update
for imagen in "${IMAGENES[@]}"; do
  echo "== $imagen"
  grype "$imagen" -o json --quiet > "seguridad/${imagen%%:*}.grype.json"
done

python scripts/resumen_grype.py
