# integracion — microservicios-pdf

Levanta juntos los cinco microservicios del contrato `microservicios-pdf` v1.0.0 con
MongoDB y Redis reales, y documenta las pruebas de integración.

| Servicio | Repo | Imagen | Público |
|---|---|---|---|
| orquestador | [vale36/Orquestador](https://github.com/vale36/Orquestador) | `orquestador:1.0.1` | sí (puerto del host `ORQUESTADOR_HOST_PORT`) |
| validacion-pdf | [valentinapenasco/validacion-pdf](https://github.com/valentinapenasco/validacion-pdf) | `validacion-pdf:1.0.0` | no |
| extraccion-texto | [NicolasPerez735/Extraccion-de-texto-pdf-](https://github.com/NicolasPerez735/Extraccion-de-texto-pdf-) | `extraccion-texto:1.0.0` | no |
| persistencia-actualizaciones | [matiasscanoo/persistencia-actualizaciones](https://github.com/matiasscanoo/persistencia-actualizaciones) | `persistencia-actualizaciones:1.0.0` | no |
| persistencia-consultas | [ManuelGomez33/persistencia-consultas](https://github.com/ManuelGomez33/persistencia-consultas) | `persistencia-consultas:1.0.0` | no |
| mongodb | — | `mongo:7.0` (volumen `mongo_data`) | no |
| redis | — | `redis:7` (volumen `redis_data`) | no |

Solo el orquestador publica un puerto. El resto se alcanza por nombre dentro de la red
`redutn`. MongoDB y Redis no publican 27017 ni 6379 porque Traefik, en la infraestructura del
equipo (`dockers/`), usa esos puertos como entrypoints TCP.

## Requisitos

- Docker y Docker Compose.
- La red externa `redutn`, una sola vez:

  ```bash
  docker network create redutn
  ```

- Los cinco repos clonados al lado de esta carpeta (`../validacion-pdf`, etc.).

## Levantar todo

1. Construir las imágenes con su tag de versión, desde la carpeta grande del proyecto:

   ```bash
   docker build -t validacion-pdf:1.0.0 validacion-pdf
   docker build -t extraccion-texto:1.0.0 Extraccion-de-texto-pdf-
   docker build -t persistencia-actualizaciones:1.0.0 persistencia-actualizaciones
   docker build -t persistencia-consultas:1.0.0 persistencia-consultas
   docker build -t orquestador:1.0.1 Orquestador
   ```

   `orquestador:1.0.1` sale de la rama `fix/fechas-milisegundos` (ver
   [Hallazgos](#hallazgos-de-la-integración)). Hasta que se mergee, construirlo desde esa rama.

2. Crear la configuración a partir de los ejemplos (no hay secretos; son nombres de la red
   interna):

   ```bash
   cp .env.example .env
   for f in env/*.env.example; do cp "$f" "${f%.example}"; done
   ```

3. Levantar y esperar a que todo quede `healthy`:

   ```bash
   docker compose up -d --wait
   docker compose ps
   ```

El orquestador queda en `http://localhost:8080` (`ORQUESTADOR_HOST_PORT`). Para bajar todo,
`docker compose down`, o `docker compose down -v` si también hay que borrar los datos.

## Variables

`.env` (lo lee el compose): versiones de imagen (`*_VERSION`) y `ORQUESTADOR_HOST_PORT`.
Todas son obligatorias: si falta una, `docker compose` no arranca.

Un archivo por servicio en `env/`, cada uno con su `.env.example` versionado:

| Archivo | Variables |
|---|---|
| `validacion.env` | `PDF_MAX_SIZE_MB`, `APP_NAME`, `APP_VERSION` |
| `extraccion.env` | `LOG_LEVEL` |
| `actualizaciones.env` | `MONGO_URI`, `MONGO_DATABASE`, `MONGO_COLLECTION`, `REDIS_URL`, `LOCK_TIMEOUT_SECONDS` |
| `consultas.env` | `MONGO_URI`, `MONGO_DATABASE`, `MONGO_COLLECTION`, `REDIS_URL`, `REDIS_TTL_SECONDS` |
| `orquestador.env` | `VALIDACION_URL`, `EXTRACCION_URL`, `PERSISTENCIA_CONSULTAS_URL`, `PERSISTENCIA_ACTUALIZACIONES_URL`, `REQUEST_TIMEOUT_SECONDS`, `RETRY_ATTEMPTS`, `RETRY_DELAY_SECONDS` |

Los `.env` reales están en `.gitignore`.

`persistencia-actualizaciones` no arranca si MongoDB no responde (decisión del servicio). Por
eso el compose espera el healthcheck de MongoDB y Redis (`depends_on: service_healthy`), y
todos los servicios tienen `restart: unless-stopped`.

## PDFs de prueba

`scripts/generar_pdfs.py` genera PDFs con texto extraíble y varias páginas. Cada archivo y
cada tanda (`--semilla`) tienen contenido distinto, así que un checksum distinto:

```bash
uv run scripts/generar_pdfs.py --cantidad 10 --paginas 10 --salida pdfs --semilla a
```

`pdfs/` no se versiona.

## Cómo probarlo

```bash
# Humo: health de los servicios internos, desde la red redutn
for s in validacion-pdf extraccion-texto persistencia-actualizaciones persistencia-consultas orquestador; do
  docker run --rm --network redutn curlimages/curl -s -o /dev/null -w "$s %{http_code}\n" http://$s:8000/health
done

# Alta de un PDF por el orquestador, con un correlation_id fijo
printf '{"archivo_base64":"%s","nombre":"documento-a-01.pdf"}' "$(base64 -w0 pdfs/documento-a-01.pdf)" > body.json
curl -X POST http://localhost:8080/pdf -H "Content-Type: application/json" \
     -H "X-Correlation-ID: aaaaaaaa-0000-4000-8000-000000000001" --data-binary @body.json

# Recorrido de esa request por todos los servicios
docker compose logs | grep aaaaaaaa-0000-4000-8000-000000000001
```

## Resultados (2026-10-07)

Docker Desktop 29.6.2 en Windows 11, con la notebook enchufada.

| Prueba | Resultado |
|---|---|
| `GET /health` de los 5 servicios | 200, con `X-Correlation-ID`. Los 7 contenedores `healthy`. |
| `POST /pdf` con un PDF de 10 páginas (11 KB) | 201, documento completo: `paginas: 10`, 36.839 caracteres, checksum SHA-256. |
| Mismo `correlation_id` en los logs | Aparece en orquestador, validación (3 ms), extracción (75 ms) y actualizaciones (26 ms); en consultas, al buscar con ese header. Total del orquestador: 124 ms. |
| Consultas lee lo que escribió actualizaciones (A10) | `GET /pdf/{id}` y `GET /pdf/checksum/{checksum}` devuelven el documento. En MongoDB, `_id` es el UUID en texto y las fechas son `ISODate`. |
| Índice único de `checksum` | Lo crea actualizaciones al arrancar (`checksum_1`, `unique: true`). |
| Mismo PDF dos veces | 409 `DUPLICATE_CHECKSUM`, con el formato común de error. No se compensa (correcto: no se guardó nada). Sigue habiendo un solo documento. |
| Caché después de `PATCH` | Se invalidan `pdf:id:*`, `pdf:checksum:*` y `pdf:list:*`. Consultas devuelve el nombre nuevo por id, checksum y listado. |
| Caché después de `POST` | Se invalida `pdf:list:*`. El listado pasa de 1 a 2 documentos. |
| Caché después de `DELETE` | 204. Se invalidan las tres claves; id y checksum dan 404 y el listado baja a 1. Un segundo `DELETE` da 404. |
| Actualizaciones apagado | 503 `DEPENDENCY_UNAVAILABLE` en 2,7 s. Log: `Attempting SAGA compensation` → `GET /pdf/checksum` en consultas (404) → `result=nothing-to-undo`, todo con el mismo `correlation_id`. El alta no se reintenta, a propósito: no es idempotente. |
| Redis apagado | Consultas sigue respondiendo desde MongoDB (200) y registra `cache no disponible` con el `correlation_id`. Actualizaciones escribe sin lock y sin invalidar (fail-open, su README). Ver deuda. |
| Errores de entrada por el orquestador | No PDF → 422 `PDF_INVALID`; PDF corrupto → 422 `PDF_CORRUPTED`; 6 MB → 413 `PDF_TOO_LARGE`; sin archivo → 400 `VALIDATION_ERROR`. |

## Hallazgos de la integración

- **Fechas del orquestador con microsegundos.** `POST /pdf` devolvía `created_at` como
  `…47.787000Z`, mientras actualizaciones y consultas devuelven `…47.787Z` (A15). Se arregló
  con TDD en la rama `fix/fechas-milisegundos` de Orquestador: dos commits rojos y el
  arreglo. De ahí sale la imagen `orquestador:1.0.1`.

## Deuda técnica

- **Consultas tarda 4 s por request con Redis caído** (7,7 s el listado). Responde bien,
  pero cada request espera al cliente Redis al leer y al escribir la caché: el cliente se crea
  sin `socket_connect_timeout` (`persistencia-consultas/app/core/database.py`). Actualizaciones
  sí lo configura y tarda 2 s. Arreglarlo con una variable nueva implica versionar el
  contrato, así que se lleva al grupo.
- **Datos viejos en caché al volver Redis** (A9, declarado por actualizaciones). Redis guarda
  un snapshot al apagarse. Si mientras estuvo caído hubo una escritura, al volver devuelve el
  listado viejo hasta que vence `REDIS_TTL_SECONDS` (se comprobó: 217 s con el nombre
  anterior). Mitigaciones posibles: Redis sin persistencia (es solo caché) o un TTL más corto.
- **Sin Traefik todavía.** El orquestador se publica directamente en el host.
- **Prueba de carga pendiente** (Fase 6). Además, la extracción no devuelve el header
  `X-Extraction-Time-Ms` que tenía el monolito: para medirla separada del total hay que mirar
  `duracion_ms` en el log de `extraccion-texto`.
