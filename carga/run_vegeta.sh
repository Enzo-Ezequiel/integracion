#!/usr/bin/env bash
# Misma prueba que k6-orquestador.js, con vegeta: 10 PDFs repetidos contra POST /pdf del
# orquestador, por Traefik, a una tasa fija durante una duración.
#
# Uso (desde integracion/carga): ./run_vegeta.sh [tasa] [duración] [semilla]
#   ./run_vegeta.sh 20/s 30s a
#
# vegeta (Go) no resuelve *.localhost en Windows: se apunta a TRAEFIK_IP y se manda el
# header Host, que es lo que Traefik usa para rutear. Al conectar por IP no hay SNI y
# Traefik entrega su certificado por defecto (TRAEFIK DEFAULT CERT), y vegeta no permite
# fijar el SNI: por eso -insecure. La validación TLS la cubre k6-orquestador.js.
set -euo pipefail

cd "$(dirname "$0")"
TASA="${1:-20/s}"
DURACION="${2:-30s}"
SEMILLA="${3:-a}"
HOST="${HOST:-pdf.universidad.localhost}"
TRAEFIK_IP="${TRAEFIK_IP:-127.0.0.1}"
PDF_DIR="${PDF_DIR:-../pdfs}"
RESULTADOS=../resultados
mkdir -p "$RESULTADOS"

command -v vegeta >/dev/null || { echo "ERROR: falta vegeta" >&2; exit 1; }

# Targets en formato JSON de vegeta: un objeto por línea, con el body en Base64.
targets="$RESULTADOS/vegeta-targets.jsonl"
: > "$targets"
for i in $(seq -w 1 10); do
  nombre="documento-$SEMILLA-$i.pdf"
  body=$(printf '{"archivo_base64":"%s","nombre":"%s"}' "$(base64 -w0 "$PDF_DIR/$nombre")" "$nombre")
  printf '{"method":"POST","url":"https://%s/pdf","header":{"Host":["%s"],"Content-Type":["application/json"]},"body":"%s"}\n' \
    "$TRAEFIK_IP" "$HOST" "$(printf '%s' "$body" | base64 -w0)" >> "$targets"
done

salida="$RESULTADOS/vegeta-$(date +%Y%m%d-%H%M%S).bin"
echo "vegeta: $TASA durante $DURACION contra https://$HOST/pdf"
vegeta attack -insecure -format=json -targets="$targets" -rate="$TASA" -duration="$DURACION" > "$salida"
# 201 y 409 (PDF repetido) son respuestas correctas: el 409 pasa por toda la extracción.
vegeta report < "$salida"
vegeta report -type="hist[0,100ms,200ms,300ms,440ms,600ms,1s]" < "$salida"
