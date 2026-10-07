# Contrato `microservicios-pdf`

```
Contrato: microservicios-pdf
Versión: 1.1.0
Formato: JSON UTF-8
Identificación: UUID
Fechas: ISO-8601 UTC
```

Este archivo es la fuente única del contrato que comparten los cinco microservicios. Los schemas
Pydantic de cada servicio son su implementación. Cualquier cambio sube la versión y se registra
en [Cambios](#cambios): compatible (minor) o `BREAKING CHANGE` (major).

## Cambios

### 1.1.0 (2026-10-07) — compatible con 1.0.0

Fija lo que la 1.0.0 dejaba abierto, tal como quedó implementado y probado en la integración.
No cambia endpoints, campos obligatorios ni códigos de error.

| # | Aclaración | Sección |
|---|---|---|
| 1 | `checksum` es SHA-256 en hexadecimal: 64 caracteres en minúsculas (el ejemplo de la 1.0.0 tenía 32). | [Documento](#modelo-común-del-documento) |
| 2 | Fechas con milisegundos y sufijo `Z` (`2026-09-14T18:00:00.000Z`). | [Documento](#modelo-común-del-documento) |
| 3 | `paginas`: opcional al crear, siempre presente en la respuesta (`null` si no vino). | [Documento](#modelo-común-del-documento) |
| 4 | Esquema en MongoDB: el UUID va en `_id`; fechas como `date` BSON. | [MongoDB](#mongodb) |
| 5 | `X-Correlation-ID`: el orquestador garantiza un UUID; los internos reutilizan lo que reciben. | [Transversales](#transversales) |
| 6 | `details` de cada error y `405` fuera del contrato. | [Errores](#contrato-común-de-errores) |
| 7 | Extracción: PDF sin texto → `200` con `"texto": ""`; error de pypdf → `422 PDF_CORRUPTED`; sin límite de tamaño propio. | [extraccion-texto](#extraccion-texto) |
| 8 | Extracción y orquestador: header `X-Extraction-Time-Ms` (informativo). | [extraccion-texto](#extraccion-texto), [orquestador](#orquestador) |
| 9 | Actualizaciones: `PATCH` → `200` con el documento; `DELETE` repetido → `404`; lock no obtenido → `503 DEPENDENCY_UNAVAILABLE`; `REDIS_TTL_SECONDS` no se consume. | [persistencia-actualizaciones](#persistencia-actualizaciones) |
| 10 | Consultas: `limit` entre 1 y 100; el total del listado no se cachea; clave `pdf:list:{sha256}`. | [persistencia-consultas](#persistencia-consultas) |
| 11 | Redis caído: todos siguen contra MongoDB (*fail-open*); Redis corre sin persistencia. | [Redis](#redis) |
| 12 | SAGA: cuándo se compensa y qué se borra. | [orquestador](#orquestador) |
| 13 | Solo el orquestador es público; extracción no se balancea por Traefik. | [Despliegue](#despliegue) |

### 1.0.0

Versión inicial, congelada antes de programar.

---

## Modelo común del documento

```json
{
  "id": "8f6f7c3e-12d5-4f57-9c6c-123456789abc",
  "nombre": "contrato.pdf",
  "checksum": "9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08",
  "texto": "Contenido extraído del PDF",
  "tamano_bytes": 245760,
  "paginas": 3,
  "created_at": "2026-09-14T18:00:00.000Z",
  "updated_at": "2026-09-14T18:00:00.000Z"
}
```

- Obligatorios: `id`, `nombre`, `checksum`, `texto`, `tamano_bytes`, `created_at`, `updated_at`.
- `id`: UUID v4 en texto.
- `checksum` *(1.1.0)*: SHA-256 del archivo, 64 caracteres hexadecimales en minúsculas
  (`hashlib.sha256(...).hexdigest()`).
- `paginas` *(1.1.0)*: opcional al crear (entero `>= 0`); en las respuestas siempre está, con
  `null` si no se informó.
- Fechas *(1.1.0)*: UTC, con milisegundos y sufijo `Z`. MongoDB guarda milisegundos: así el
  mismo documento devuelve exactamente la misma fecha en todos los servicios.
- El binario del PDF no se persiste.

## Contrato común de errores

```json
{
  "error": {
    "code": "PDF_INVALID",
    "message": "El archivo no es un PDF válido",
    "details": {},
    "correlation_id": "8f6f7c3e-12d5-4f57-9c6c-123456789abc"
  }
}
```

| Código | HTTP |
|---|---|
| `VALIDATION_ERROR` | 400 |
| `PDF_INVALID` | 422 |
| `PDF_TOO_LARGE` | 413 |
| `PDF_CORRUPTED` | 422 |
| `RESOURCE_NOT_FOUND` | 404 |
| `DUPLICATE_CHECKSUM` | 409 |
| `DEPENDENCY_UNAVAILABLE` | 503 |
| `DATABASE_ERROR` | 503 |
| `INTERNAL_ERROR` | 500 |

*(1.1.0)*

- `details` es siempre un objeto (aunque sea `{}`). Los clientes deciden por `code`, nunca por
  `details`. Contenido habitual: `VALIDATION_ERROR` → `{"errors": [...]}`; `PDF_TOO_LARGE` →
  `{"max_size_bytes", "received_size_bytes"}`; `DUPLICATE_CHECKSUM` → `{"checksum"}`;
  `DEPENDENCY_UNAVAILABLE` → `{"reason"}` si hay un motivo útil.
- Los errores de validación del request no devuelven el valor recibido (puede ser el PDF en
  Base64).
- Una ruta inexistente responde `404 RESOURCE_NOT_FOUND` con este formato.
- **Método no permitido (`405`) queda fuera del contrato**: ningún cliente del sistema usa
  métodos no definidos. Cada servicio puede responder el `405` de su framework o envolverlo en el
  formato común.

## Transversales

- Todo servicio expone `GET /health` → `200 {"status": "ok"}`, sin consultar sus dependencias.
- `X-Correlation-ID`: si llega se reutiliza y si no se genera un UUID; se devuelve en la
  respuesta, se envía a cada servicio llamado y aparece en los logs y en el cuerpo de los errores.
  *(1.1.0)* El orquestador, que es la entrada pública, **garantiza un UUID**: si el header falta o
  no es un UUID, genera uno nuevo. Los servicios internos reutilizan el valor que reciben (siempre
  un UUID cuando los llama el orquestador).
- Logs a `stdout`, con el `correlation_id` en cada línea.

## Servicios

### `validacion-pdf`

- **Hace:** recibir el archivo, decodificar Base64, confirmar que sea PDF, validar el tamaño máximo.
- **No hace:** extraer texto, calcular checksum, usar MongoDB ni Redis.
- `POST /validar` — `{"archivo_base64", "nombre"}` → `{"valido": true, "nombre", "tamano_bytes"}`.
- Error: `{"valido": false, "error": {...}}` con el formato común.
- Variables: `PDF_MAX_SIZE_MB`.

### `extraccion-texto`

- **Hace:** recibir un PDF validado, extraer el texto de todas las páginas con `pypdf`, contar las
  páginas y calcular el checksum SHA-256.
- **No hace:** persistir, usar MongoDB ni Redis.
- `POST /extraer` — `{"archivo_base64", "nombre"}` →
  `{"nombre", "texto", "checksum", "tamano_bytes", "paginas"}`.
- Variables: ninguna del contrato.

*(1.1.0)*

| Caso | Respuesta |
|---|---|
| Base64 inválido, archivo vacío o sin la firma `%PDF` | `422 PDF_INVALID` |
| `pypdf` no puede abrir, recorrer o extraer | `422 PDF_CORRUPTED` |
| PDF sin texto (por ejemplo, escaneado) | `200` con `"texto": ""`: es un PDF válido |
| Tamaño | No se controla acá: lo hace `validacion-pdf`, y el orquestador siempre valida antes |

- Header de respuesta `X-Extraction-Time-Ms`: milisegundos que tardó la extracción (decodificar,
  pypdf y checksum). Informativo, para medir la extracción aparte del total en las pruebas de carga.

### `persistencia-actualizaciones`

- **Hace:** crear, modificar y eliminar documentos; invalidar Redis; aplicar la estrategia de
  concurrencia. Es el **único servicio que escribe** en la colección.
- `POST /pdf` — `{"nombre", "checksum", "texto", "tamano_bytes", "paginas"}` → `201` con el documento.
- `PATCH /pdf/{id}` — `{"nombre"}` → *(1.1.0)* `200` con el documento actualizado.
- `DELETE /pdf/{id}` → `204`.
- `checksum` con índice único: duplicado → `409 DUPLICATE_CHECKSUM`.
- Variables: `MONGO_URI`, `MONGO_DATABASE`, `MONGO_COLLECTION`, `REDIS_URL`,
  `REDIS_TTL_SECONDS`, `LOCK_TIMEOUT_SECONDS`.

*(1.1.0)*

- Campos extra en el body → `400 VALIDATION_ERROR`; enteros estrictos; `nombre` de 1 a 255
  caracteres y no en blanco; `tamano_bytes >= 1`.
- `id` de la ruta que no es UUID → `400 VALIDATION_ERROR`, sin consultar la base.
- `DELETE` de un id inexistente o ya borrado → `404 RESOURCE_NOT_FOUND`. Para la compensación
  SAGA ese `404` significa "ya no está": cuenta como éxito.
- Concurrencia: lock por recurso en Redis con `LOCK_TIMEOUT_SECONDS`. Si no se obtiene a tiempo →
  `503 DEPENDENCY_UNAVAILABLE` con `details.reason = "lock_timeout"` (no se guardó nada).
- `REDIS_TTL_SECONDS` no se consume: este servicio no escribe la caché, solo la invalida. El TTL
  lo aplica `persistencia-consultas`.
- Después de cada escritura exitosa invalida `pdf:id:{id}`, `pdf:checksum:{checksum}` y todas las
  `pdf:list:*`.

### `persistencia-consultas`

- **Hace:** listar, consultar por id y por checksum, con Redis como caché (*cache-aside*).
- **No hace:** modificar información.
- `GET /pdf?limit=20&offset=0` → `{"items", "total", "limit", "offset"}`.
- `GET /pdf/{id}`, `GET /pdf/checksum/{checksum}`.
- Claves: `pdf:id:{id}`, `pdf:checksum:{checksum}`, `pdf:list:{hash-de-parametros}`.
- Variables: `MONGO_URI`, `MONGO_DATABASE`, `MONGO_COLLECTION`, `REDIS_URL`, `REDIS_TTL_SECONDS`.

*(1.1.0)*

- `limit` entre 1 y 100, `offset >= 0`; fuera de rango o no numérico → `400 VALIDATION_ERROR`.
- Listado ordenado por `created_at` descendente.
- `hash-de-parametros` = SHA-256 de `limit={limit}&offset={offset}`.
- El `total` no se cachea (no tiene clave del contrato y no se invalidaría al escribir).
- Los documentos inexistentes no se cachean.

### `orquestador`

- **Hace:** recibir la solicitud pública; llamar a validación, extracción y persistencia; propagar
  `X-Correlation-ID`; aplicar timeout y retry; ejecutar la compensación SAGA.
- **No hace:** usar MongoDB, Redis ni `pypdf`.
- `POST /pdf` — `{"archivo_base64", "nombre"}` → `201` con el documento de persistencia.
- Variables: `VALIDACION_URL`, `EXTRACCION_URL`, `PERSISTENCIA_CONSULTAS_URL`,
  `PERSISTENCIA_ACTUALIZACIONES_URL`, `REQUEST_TIMEOUT_SECONDS`, `RETRY_ATTEMPTS`,
  `RETRY_DELAY_SECONDS`.

*(1.1.0)*

- Los errores de las dependencias se devuelven con su `code` y el HTTP de la tabla común.
- Reintenta (`RETRY_ATTEMPTS`) solo las llamadas idempotentes: validar, extraer, consultar y
  borrar. El alta en persistencia **no** se reintenta.
- **SAGA.** Se compensa solo cuando el resultado del alta es incierto: persistencia no respondió
  (timeout, conexión o respuesta fuera del contrato). La compensación busca el checksum en
  `persistencia-consultas` y, si el documento se creó durante esta request (`created_at` posterior
  a su inicio), lo borra con `DELETE /pdf/{id}`. Es idempotente y queda registrada en los logs. No
  se compensa ante un error del contrato (`400`, `409`, `422`, `503 lock_timeout`): no se guardó
  nada, y ante un `409` borrar por checksum eliminaría un documento que ya existía.
- La respuesta `201` reenvía `X-Extraction-Time-Ms` si extracción lo informó.

## MongoDB

*(1.1.0)* Colección `MONGO_COLLECTION` de `MONGO_DATABASE`, compartida: escribe
`persistencia-actualizaciones`, lee `persistencia-consultas`.

| Campo | Tipo BSON | Notas |
|---|---|---|
| `_id` | string | el `id` del documento (UUID v4), no `ObjectId` |
| `nombre`, `checksum`, `texto` | string | `checksum` con índice único (`checksum_1`), creado al iniciar actualizaciones |
| `tamano_bytes` | int64 | |
| `paginas` | int32 o `null` | |
| `created_at`, `updated_at` | date | UTC, milisegundos |

## Redis

- Todos los servicios usan las mismas claves (ver cada servicio).
- Toda escritura en MongoDB va seguida de la invalidación de sus claves.
- *(1.1.0)* **Redis caído (*fail-open*):** la caché acelera pero no es un punto único de falla.
  Consultas sigue contra MongoDB; actualizaciones escribe sin lock (el índice único garantiza la
  unicidad) y sin invalidar. Se registra un `WARNING` con el `correlation_id`. Los clientes de
  Redis usan timeouts cortos y no reintentan.
- *(1.1.0)* **Redis sin persistencia:** es solo caché; en el despliegue corre sin snapshot ni AOF
  y arranca vacío, para no recuperar datos que se invalidaron mientras estaba caído.

## Despliegue

*(1.1.0)*

- Todos los servicios en la red externa `redutn`. Ninguno publica puertos en el host.
- **Solo el orquestador es público**, a través de Traefik (`traefik.enable=true`). Validación,
  extracción y persistencia son internos.
- Las réplicas de extracción las reparte Docker entre conexiones. **No** se rutea extracción por
  Traefik para balancear por request: la convertiría en un servicio publicado. Si hace falta más
  reparto, se resuelve con más procesos dentro de extracción.
