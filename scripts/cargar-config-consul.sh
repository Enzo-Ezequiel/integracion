#!/bin/sh
# Contrato 1.6.0: carga en el KV de Consul la configuración de cada microservicio, desde
# env/<archivo>.env, bajo config/<nombre en Consul>/<VARIABLE>. Lo corre el contenedor
# consul-config del compose, una vez por despliegue y antes que los microservicios
# (12-Factor XII). Usa CONSUL_HTTP_ADDR y CONSUL_HTTP_TOKEN_FILE (token config-loader).
#
# No carga CONSUL_ENABLED, CONSUL_HTTP_ADDR ni CONSUL_HTTP_TOKEN_FILE: cómo conectarse a
# Consul no puede venir de Consul. Tampoco muestra los valores (pueden traer URIs).
set -eu

CONFIG_DIR=${CONFIG_DIR:-/config}

cargar() {
  archivo="$CONFIG_DIR/$1"
  servicio=$2
  [ -f "$archivo" ] || { echo "falta $archivo" >&2; exit 1; }
  # Se borra lo anterior: una variable quitada del .env no queda vieja en Consul.
  consul kv delete -recurse "config/$servicio/" >/dev/null
  claves=0
  while IFS= read -r linea || [ -n "$linea" ]; do
    linea=$(printf '%s' "$linea" | tr -d '\r')
    case "$linea" in '' | '#'*) continue ;; esac
    clave=${linea%%=*}
    valor=${linea#*=}
    case "$clave" in CONSUL_ENABLED | CONSUL_HTTP_ADDR | CONSUL_HTTP_TOKEN_FILE) continue ;; esac
    [ -n "$valor" ] || continue
    # Por stdin ("-"): un valor que empieza con @ no se toma como nombre de archivo.
    printf '%s' "$valor" | consul kv put "config/$servicio/$clave" - >/dev/null
    claves=$((claves + 1))
  done <"$archivo"
  echo "config/$servicio/: $claves claves"
}

cargar validacion.env validacion-pdf
cargar extraccion.env extraccion
cargar actualizaciones.env persistencia-actualizaciones
cargar consultas.env persistencia-consultas
cargar orquestador.env orquestador
