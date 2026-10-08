# integracion — microservicios-pdf

Levanta juntos los cinco microservicios del contrato `microservicios-pdf` v1.2.0 con
MongoDB y Redis reales, y documenta las pruebas de integración.

El contrato completo, con su registro de cambios, está en [CONTRATO.md](CONTRATO.md). La 1.2.0
(compatible) incorpora lo que pidió el profesor el 2026-10-07: `/health` con dependencias, logs
(12-Factor XI), finalización segura (12-Factor IX) y balanceo de extracción por Traefik. Qué
está implementado y qué falta se ve en [Decisiones y respuestas del
profesor](#decisiones-y-respuestas-del-profesor-2026-10-07).

| Servicio | Repo | Imagen | Público |
|---|---|---|---|
| orquestador | [vale36/Orquestador](https://github.com/vale36/Orquestador) | `orquestador:1.0.4` | sí, por Traefik: `https://pdf.universidad.localhost` |
| validacion-pdf | [valentinapenasco/validacion-pdf](https://github.com/valentinapenasco/validacion-pdf) | `validacion-pdf:1.0.3` | no |
| extraccion-texto | [NicolasPerez735/Extraccion-de-texto-pdf-](https://github.com/NicolasPerez735/Extraccion-de-texto-pdf-) | `extraccion-texto:1.0.4` (3 réplicas) | no; la balancea `traefik-interno` |
| traefik-interno | — | `traefik:v3.6` | no (sin puertos publicados) |
| persistencia-actualizaciones | [matiasscanoo/persistencia-actualizaciones](https://github.com/matiasscanoo/persistencia-actualizaciones) | `persistencia-actualizaciones:1.0.3` | no |
| persistencia-consultas | [ManuelGomez33/persistencia-consultas](https://github.com/ManuelGomez33/persistencia-consultas) | `persistencia-consultas:1.0.3` | no |
| mongodb | — | `mongo:7.0` (volumen `mongo_data`) | no |
| redis | — | `redis:7` (volumen `redis_data`) | no |

Ningún servicio publica puertos en el host. El orquestador es el único con labels de Traefik
(`traefik.enable=true`); el Traefik del equipo (`dockers/traefik`, `exposedByDefault: false`)
lo publica por HTTPS. El resto se alcanza solo por nombre dentro de la red `redutn`. MongoDB
y Redis no publican 27017 ni 6379 porque Traefik usa esos puertos como entrypoints TCP.

## Requisitos

- Docker y Docker Compose.
- La red externa `redutn`, una sola vez:

  ```bash
  docker network create redutn
  ```

- Los cinco repos clonados al lado de esta carpeta (`../validacion-pdf`, etc.).
- El Traefik del equipo levantado (`dockers/traefik`, en la carpeta grande del proyecto):

  ```bash
  cd ../dockers/traefik && docker compose up -d
  ```

  Publica 80 (redirige a HTTPS), 443, 6379 y 27017, con certificados mkcert para
  `*.universidad.localhost` en `certs/`. Con la CA instalada, el navegador y k6 validan el
  certificado sin avisos. Ver la sección siguiente.

### La infraestructura de la cátedra (`dockers/`) no está en este repo

`dockers/` es la infraestructura que provee la cátedra (Traefik y ejemplos de MongoDB y
whoami), igual para todo el curso. **No se versiona a propósito**, por indicación del
profesor: incluye la clave privada del certificado (`certs/key.pem`), un ejecutable de
terceros (`mkcert.exe`) y archivos `.env`, y los certificados de mkcert son propios de cada
máquina. Cada integrante la tiene en su carpeta del proyecto, al lado de este repo.

Lo que este repo necesita de ese Traefik:

| Requisito | Valor |
|---|---|
| Red | externa `redutn` |
| Descubrimiento | proveedor Docker con `exposedByDefault: false` (solo se publica lo que tiene `traefik.enable=true`) |
| Entrypoints | `http` en 80 con redirección a `https`; `https` en 443 |
| Certificado | `*.universidad.localhost` en `certs/cert.pem` y `certs/key.pem` |

Para generar los certificados en una máquina nueva, con
[mkcert](https://github.com/FiloSottile/mkcert) descargado de su página oficial y desde
`dockers/traefik`:

```bash
mkcert -install
mkcert -cert-file certs/cert.pem -key-file certs/key.pem "universidad.localhost" "*.universidad.localhost" 127.0.0.1 ::1
```

  El `curl` de Windows (Schannel) exige comprobar la revocación y los certificados de mkcert
  no la publican (`CRYPT_E_NO_REVOCATION_CHECK`): usar `curl --ssl-no-revoke`, que sigue
  validando la cadena y el nombre. No hace falta `-k`.

## Levantar todo con un comando

```bash
./scripts/levantar.sh            # verifica, construye, levanta y hace el humo
./scripts/levantar.sh --tests    # además corre la suite de los cinco repos
./scripts/levantar.sh --sin-build
```

El script verifica las herramientas, muestra en qué rama está cada repo, crea la red
`redutn` y los `.env` que falten a partir de los `.env.example`, construye cada imagen con el
tag del `.env`, levanta Traefik si no corre, levanta el stack esperando los healthchecks y
prueba `/health` de los cinco servicios y del orquestador por Traefik. No usa secretos.

Los pasos, a mano:

## Levantar todo

1. Construir las imágenes con su tag de versión, desde la carpeta grande del proyecto:

   ```bash
   docker build -t validacion-pdf:1.0.3 validacion-pdf
   docker build -t extraccion-texto:1.0.4 Extraccion-de-texto-pdf-
   docker build -t persistencia-actualizaciones:1.0.3 persistencia-actualizaciones
   docker build -t persistencia-consultas:1.0.3 persistencia-consultas
   docker build -t orquestador:1.0.4 Orquestador
   ```

   Estas versiones implementan el contrato 1.2.0 y salen de las ramas
   `feat/logs-y-apagado-seguro` (extracción, validación, orquestador) y `feat/contrato-1.2.0`
   (las dos persistencias). Hasta que se mergeen, construir desde esas ramas;
   `scripts/levantar.sh` muestra en qué rama está cada repo.

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

El orquestador queda en `https://pdf.universidad.localhost` (`ORQUESTADOR_HOST`). El dashboard
de Traefik (`https://traefik.universidad.localhost`) muestra un solo router de Docker,
`orquestador@docker`. Para bajar todo,
`docker compose down`, o `docker compose down -v` si también hay que borrar los datos.

## Variables

`.env` (lo lee el compose): versiones de imagen (`*_VERSION`) y `ORQUESTADOR_HOST` (el host
de la regla de Traefik).
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
curl --ssl-no-revoke -X POST https://pdf.universidad.localhost/pdf -H "Content-Type: application/json" \
     -H "X-Correlation-ID: aaaaaaaa-0000-4000-8000-000000000001" --data-binary @body.json

# Recorrido de esa request por todos los servicios
docker compose logs | grep aaaaaaaa-0000-4000-8000-000000000001
```

## Postman

`postman/` tiene una colección por microservicio y una del flujo completo (formato v2.1,
variable `baseURL`). Cada request manda un `X-Correlation-ID` nuevo y verifica que vuelva,
el status, la forma de la respuesta y el formato común de errores.

| Colección | `baseURL` por defecto | Requests | Qué cubre |
|---|---|---|---|
| `validacion-pdf` | `http://localhost:8000` | 4 | health, PDF válido, no-PDF → 422, sin nombre → 400 |
| `extraccion-texto` | `http://localhost:8000` | 4 | health, PDF de 2 páginas (texto, SHA-256, páginas), corrupto → 422, Base64 inválido → 422 |
| `persistencia-actualizaciones` | `http://localhost:8000` | 8 | crear, duplicado → 409, campo extra → 400, PATCH, DELETE → 204, DELETE otra vez y PATCH inexistente → 404 |
| `persistencia-consultas` | `http://localhost:8000` | 5 | health, listado, por id y por checksum (toma el primero del listado), inexistente → 404 |
| `orquestador` | `https://pdf.universidad.localhost` | 6 | health, alta (201 o 409), duplicado → 409, no-PDF y corrupto → 422, sin archivo → 400 |
| `flujo-completo` | `https://pdf.universidad.localhost` | 3 | genera un PDF distinto en cada corrida: alta → 201 con el texto extraído, repetido → 409 |

Las de los servicios internos apuntan a `localhost:8000`, para correr cada servicio solo
(su `docker run -p 8000:8000` o `uvicorn`). En la integración no publican puertos: se prueban
desde la red `redutn` con newman.

```bash
docker run --rm --network redutn -v "$(pwd)/postman:/etc/newman" postman/newman:alpine \
  run validacion-pdf.postman_collection.json --env-var baseURL=http://validacion-pdf:8000
```

Resultado del 2026-10-07: las 6 colecciones en verde, 29 requests y 85 assertions sin
fallos. Las dos públicas se corrieron con `baseURL=http://orquestador:8000`: dentro de un
contenedor, Node resuelve `*.localhost` a sí mismo. Desde Postman en la PC,
`https://pdf.universidad.localhost` llega a Traefik. Si Postman no reconoce la CA de mkcert,
desactivar "SSL certificate verification" o agregar `rootCA.pem` (`mkcert -CAROOT`) en
Settings → Certificates.

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
| Timeout de extracción (`REQUEST_TIMEOUT_SECONDS=0.02`, PDF de 60 páginas) | 503 `DEPENDENCY_UNAVAILABLE` en 1,1 s. Log de los reintentos: `intento=2 de 3`, `3 de 3`, `motivo=ReadTimeout`. Sin compensación, porque no se llegó a persistir. Extracción igual terminó las 3 peticiones abandonadas (ver deuda). |
| Traefik | `https://pdf.universidad.localhost/health` → 200; por HTTP → 301 a HTTPS. Validación, extracción y persistencia por Traefik → 404: no están expuestos. `POST /pdf` por Traefik → 201 y el mismo `correlation_id` en los 5 servicios. |
| Redis MISS vs HIT en consultas | `GET /pdf/{id}`: MISS 8,2 ms; HIT 1,3–1,7 ms. Después del MISS queda la clave con TTL de 300 s. |

## Prueba de carga (k6)

`carga/k6-orquestador.js` entra por Traefik (HTTPS, validando el certificado; con
`-e INSECURE=1` no lo valida) y reproduce el escenario del profesor: 10 PDFs de 10 páginas que se
repiten durante 30 s contra `POST /pdf` del orquestador. Se arranca con la base vacía
(`docker compose down -v`): la primera vuelta da 201 y las siguientes 409
`DUPLICATE_CHECKSUM`. Las dos cuentan como correctas, porque el 409 también pasa por
validación y extracción completas. Los checks verifican el texto en los 201 y el código en
los 409.

```bash
cd carga
k6 run -e VUS=5 -e DURATION=30s k6-orquestador.js
docker compose up -d --scale extraccion-texto=1   # para medir con una sola réplica
```

k6 no resuelve `*.localhost` en Windows (`lookup ... no such host`): el script apunta el host a
`TRAEFIK_IP` (por defecto `127.0.0.1`) con la opción `hosts` de k6, sin tocar el archivo
`hosts` del sistema.

El tiempo de extracción se mide aparte del total con `X-Extraction-Time-Ms`: lo calcula
`extraccion-texto` y el orquestador (desde `orquestador:1.0.2`) lo reenvía en cada `201`.
k6 lo registra en la métrica `tiempo_extraccion_ms`; los `409` no lo traen. Los resultados de
abajo son anteriores a la 1.0.2: ahí el tiempo de extracción se tomó de `duracion_ms` en el log
de `extraccion-texto`.

Resultados del 2026-10-07 (Docker Desktop, 12 CPUs, notebook enchufada; 100 % de checks OK y
0 errores en todas las corridas):

| Réplicas de extracción | VUs | Total prom | Total p95 | Extracción prom | Extracción p95 | PDF/s |
|---|---|---|---|---|---|---|
| 1 | 1 | 112 ms | 182 ms | 89 ms | 146 ms | 8,9 |
| 1 | 3 | 354 ms | 586 ms | 300 ms | 531 ms | 8,4 |
| 1 | 5 | 598–604 ms | 1,02–1,12 s | 509–523 ms | 898–1003 ms | 8,3 |
| 3 | 1 | 110 ms | 188 ms | 86 ms | 148 ms | 9,0 |
| 3 | 5 | **120 ms** | **173 ms** | 90 ms | 135 ms | **41,6** |
| 3 | 10 | 243 ms | 417 ms | 193 ms | 341 ms | 41,1 |
| 3, por Traefik (HTTPS) | 5 | 122 ms | 175 ms | 91 ms | 133 ms | 40,7 |
| 3, por Traefik (HTTPS) | 10 | 232 ms | 336 ms | 184 ms | 274 ms | 42,8 |

Las filas sin Traefik se midieron publicando el orquestador directo en el host (antes de
sumar Traefik). Traefik con TLS no agrega latencia apreciable.

Lectura:

- **Con 1 réplica el techo es ~8,3 PDF/s**, igual que el monolito (~11 PDF/s por proceso).
  Al subir los VUs no aumenta el rendimiento: crece la cola, y crece *dentro* de la
  extracción. `extraer` es un `def` sincrónico que FastAPI corre en su threadpool, así que
  los hilos de pypdf compiten por el GIL. Varias extracciones a la vez en un proceso tardan
  cada una más y el total no sube.
- **Con 3 réplicas se llega a ~41 PDF/s** (5 veces más con 5 VUs). Es más que el triple
  porque cada proceso recibe menos concurrencia y pierde menos por la contención del GIL.
- **Contra el profesor (440 ms):** con 3 réplicas el promedio queda en 120 ms con 5 VUs y en
  243 ms con 10 VUs (p95 417 ms). Su máquina, sus PDFs y su concurrencia no son los mismos:
  hay que repetirlo con su escenario cuando lo tengamos.
- **Reparto entre réplicas y resultados bimodales** *(resuelto con `traefik-interno`, ver
  [Balanceo de extracción](#balanceo-de-extracción-con-traefik-interno-contrato-120))*. El orquestador (httpx) reutiliza
  conexiones keep-alive y el DNS de Docker elige réplica *por conexión*, no por request. Cada
  VU termina usando una conexión fija: con 1 VU todo va a una réplica (272 de 272), y con 5
  VUs hay un 39 % de probabilidad (3·(2/3)⁵) de que alguna réplica no reciba ninguna
  conexión. Se vio en las mediciones: con las 3 réplicas en uso, 5 VUs dan 36–40 PDF/s;
  cuando una queda afuera (reparto 394 / 326 / 0), 24–25 PDF/s. Con 10 VUs la probabilidad
  baja a ~5 % y se mantiene en 40–42 PDF/s. **Para medir:** reiniciar el orquestador antes de
  cada corrida y revisar el reparto (`docker compose logs extraccion-texto`). **Para
  arreglarlo** (decisión del grupo): rutear orquestador → extracción por Traefik, que balancea
  por request, o limitar el keep-alive del cliente httpx hacia extracción.
- **Python 3.11 contra 3.12 en extracción** (misma base Debian 13, 1 VU, que es reproducible):
  extracción 88–92 ms con 3.11 y 97–98 ms con 3.12; total 116–119 ms contra 123–124 ms. Por
  eso `extraccion-texto:1.0.2` usa `python:3.11-slim`.
- **Con las imágenes finales** (`extraccion-texto:1.0.2`, 3 réplicas en uso, por Traefik):
  5 VUs → 131–137 ms promedio, p95 ~245 ms, 36–38 PDF/s; 10 VUs → 236–247 ms promedio,
  p95 350–425 ms, 40–42 PDF/s. La máquina rindió algo menos que a la mañana (1.0.0 dio entre
  24 y 40 PDF/s en las mismas condiciones), así que las comparaciones finas hay que hacerlas
  en la misma sesión.

## Balanceo de extracción con `traefik-interno` (contrato 1.2.0)

El orquestador llama a extracción a través de `traefik-interno`
(`EXTRACCION_URL=http://traefik-interno`), un Traefik propio de este compose que reparte **por
request** entre las réplicas. No publica puertos y solo descubre los contenedores con la label
`microservicios-pdf.balanceo=interno`; extracción no lleva `traefik.enable=true`, así que el
Traefik de la cátedra no la publica (su API solo lista el router `orquestador@docker`). No se
usa el de la cátedra porque redirige todo el HTTP a HTTPS (se probó: `301`), y adentro de
`redutn` las llamadas son HTTP plano.

```bash
docker compose up -d                                                             # sin cortocircuito
docker compose -f docker-compose.yml -f docker-compose.cortocircuito.yml up -d   # con cortocircuito
```

Cortocircuito: middleware `circuitBreaker` de Traefik con
`NetworkErrorRatio() > 0.30 || ResponseCodeRatio(500, 600, 0, 600) > 0.30`. No se programa:
el código solo reintenta (`RETRY_ATTEMPTS`).

Resultados del 2026-10-07 (k6, 20 s por corrida, 3 réplicas, misma sesión; 100 % de checks):

| Orquestador → extracción | VUs | Promedio | p95 | PDF/s | Reparto entre réplicas |
|---|---|---|---|---|---|
| Directo (DNS de Docker) | 1 | 166 ms | 307 ms | 6,0 | 120 / 0 / 0 |
| Directo | 5 | 297 ms | 593 ms | 16,7 | 187 / 150 / **0** |
| Directo | 10 | 236 ms | 341 ms | 42,1 | 283 / 282 / 283 |
| `traefik-interno` | 1 | 127 ms | 221 ms | 7,8 | 52 / 53 / 52 |
| `traefik-interno` | 5 | **133 ms** | **189 ms** | **37,4** | 250 / 250 / 250 |
| `traefik-interno` | 10 | 240 ms | 339 ms | 41,2 | 278 / 277 / 277 |
| `traefik-interno` + cortocircuito | 1 | 120 ms | 221 ms | 8,3 | 55 / 56 / 55 |
| `traefik-interno` + cortocircuito | 5 | 135 ms | 195 ms | 36,8 | 248 / 246 / 248 |
| `traefik-interno` + cortocircuito | 10 | 244 ms | 344 ms | 40,6 | 274 / 274 / 273 |

- **El reparto queda parejo con cualquier cantidad de clientes.** Directo, con 5 VUs una réplica
  quedó sin trabajo y se procesó menos de la mitad. Con 10 VUs las dos variantes empatan: la
  capacidad es la misma (3 procesos); Traefik evita que dependa de la suerte de las conexiones.
- **El salto extra por Traefik no se nota** (127 ms contra 166 ms con 1 VU, porque directo una
  sola réplica atendía todo). El cortocircuito no cambia los tiempos cuando todo anda bien.

Fallas con 5 VUs, réplica 3 detenida a los 6 s (20 s de carga):

| Falla | Cortocircuito | Checks | Máximo | Reintentos del orquestador |
|---|---|---|---|---|
| `docker kill` (SIGKILL) | no | 100 % | 11,3 s | 2 × `502`, 4 × `ReadTimeout` |
| `docker kill` (SIGKILL) | sí | 100 % | 11,3 s | 2 × `502`, 7 × `ReadTimeout` |
| `docker stop` (SIGTERM) | no | 100 % | 11,2 s | 3 × `502`, 2 × `ReadTimeout` |
| `docker stop`, con `dialTimeout` de 1 s | no | 100 % | **2,2 s** | 3 × `502`, 3 × `504` |

- El cliente nunca vio un error: los reintentos del orquestador cubren la réplica caída.
- Los `ReadTimeout` eran requests que Traefik mandaba a la IP de la réplica ya detenida, en el
  instante antes de enterarse por Docker: conectar esperaba hasta el timeout del orquestador
  (10 s). Con `dialTimeout: 1s` (`traefik-interno/dinamico.yml`) Traefik responde `504`
  enseguida y el orquestador reintenta contra otra réplica.
- Con `SIGKILL`, las extracciones que esa réplica tenía en curso se pierden sin respuesta y se
  recuperan por timeout. Con `docker stop` la réplica las termina antes de salir (código 0); ver
  [Finalización segura](#finalización-segura-12-factor-ix).
- **El cortocircuito no se activó** en estas pruebas: una réplica caída sobre tres no supera el
  30 % de errores, y Traefik la saca de la lista. Sirve cuando una réplica sigue viva pero
  devuelve errores. Queda definido y desactivado por defecto.

## Prueba de carga (vegeta)

`carga/run_vegeta.sh` hace la misma prueba que k6 pero a **tasa fija**, como el
`run_vegeta.sh` del profesor. Los reportes binarios quedan en `resultados/` (no se
versiona).

```bash
cd carga
./run_vegeta.sh 40/s 30s a      # tasa, duración, semilla de los PDFs
```

vegeta no resuelve `*.localhost` en Windows y no permite fijar el SNI. Por eso se conecta a
`TRAEFIK_IP` con el header `Host` (Traefik rutea por ese header) y con `-insecure`: sin SNI,
Traefik entrega su certificado por defecto. La validación TLS la cubre k6. vegeta cuenta como
"Success" solo los 2xx; acá todas las respuestas fueron 409, que es el resultado correcto con
PDFs repetidos.

Resultados del 2026-10-07 (3 réplicas de extracción, por Traefik):

| Tasa | Promedio | p50 | p95 | p99 | Respuestas |
|---|---|---|---|---|---|
| 20/s | 128 ms | 115 ms | 222 ms | 275 ms | 600 × 409 |
| 40/s | 154 ms | 138 ms | 280 ms | 446 ms | 1200 × 409 |
| 60/s | 20,6 s | 22,8 s | 30 s | 30 s | 971 × 409 y 829 cortadas por el timeout de vegeta (30 s) |

**Escenario del profesor: 10 000 peticiones** (2026-10-07 noche, `extraccion-texto:1.0.3` con
`traefik-interno`):

| Tasa | Peticiones | Promedio | p50 | p95 | p99 | Máximo | Respuestas |
|---|---|---|---|---|---|---|---|
| 30/s | 10 020 | **115 ms** | 104 ms | 185 ms | 258 ms | 685 ms | 10 020 × 409, 0 errores |
| 40/s | 10 000 | 10,4 s | 2,7 s | 30 s | 30 s | 30 s | 5319 × 409, 1929 × 404, 2752 cortadas |

- **30/s se sostiene** durante los 5,5 minutos, muy por debajo de los 440 ms del profesor.
- **40/s está en el límite** de la capacidad (~41 PDF/s): en 30 s alcanzaba (154 ms), pero en
  4 minutos cualquier baja de rendimiento arma una cola que no se vacía. Durante la saturación
  el healthcheck del orquestador (timeout 2 s) falló tres veces, Docker lo marcó `unhealthy` y
  el Traefik de la cátedra lo sacó de la rota: de ahí los `404`. Se recuperó solo al bajar la
  carga.

A 60/s se supera la capacidad medida con k6 (~41 PDF/s con 3 réplicas) y la cola crece sin
límite. El sistema no se cae: los contenedores siguen `healthy`, el orquestador no devuelve
ningún 5xx y termina procesando las 3600 peticiones (las 829 cortadas se cortaron del lado
del cliente).

## Seguridad de imágenes (Grype)

```bash
./scripts/grype.sh
```

Corre Grype como contenedor (`anchore/grype`, base de vulnerabilidades en el volumen
`grype-db`) sobre las cinco imágenes del `.env` y escribe `seguridad/resumen.md`. Los JSON
completos quedan en `seguridad/` sin versionar.

Resultado del 2026-10-07 (Grype 0.120.1), antes y después de los arreglos:

| Imagen antes | Base | Critical | High | Total | → | Imagen después | Base | Critical | High | Total |
|---|---|---|---|---|---|---|---|---|---|---|
| `extraccion-texto:1.0.0` | Debian 12 | **16** | 136 | 421 | → | `extraccion-texto:1.0.2` | Debian 13 | 0 | 56 | 174 |
| `persistencia-actualizaciones:1.0.0` | Debian 13 | 0 | 59 | 179 | → | `persistencia-actualizaciones:1.0.1` | Debian 13 | 0 | 57 | 176 |
| `persistencia-consultas:1.0.0` | Debian 13 | 0 | 61 | 191 | → | `persistencia-consultas:1.0.1` | Debian 13 | 0 | 57 | 185 |
| `validacion-pdf:1.0.0` | Debian 13 | 0 | 67 | 200 | → | `validacion-pdf:1.0.1` | Debian 13 | 0 | 57 | 176 |
| `orquestador:1.0.1` | Debian 13 | 0 | 55 | 172 | → | `orquestador:1.0.1` | Debian 13 | 0 | 55 | 172 |

Qué se arregló (detalle en [Hallazgos](#hallazgos-de-la-integración)):

- **Los 16 Critical de extracción** venían de su base `uv:python3.11-bookworm-slim`
  (Debian 12: openssl, gnutls, perl, glibc). Ahora usa `python:3.11-slim` (Debian 13).
- **Las vulnerabilidades High de paquetes de Python** quedaron en cero en las cinco imágenes:
  `starlette` y `python-multipart` (validación), `pymongo` (consultas), y `wheel` y
  `jaraco-context` del `setuptools` preinstalado en `python:3.11-slim` (extracción y
  actualizaciones).

Qué queda:

- **~55 High por imagen, todas del sistema operativo Debian 13** (las mismas en las cinco,
  porque comparten base). Casi ninguna tiene arreglo publicado todavía: se resuelven
  reconstruyendo las imágenes cuando Debian publique las versiones corregidas
  (`./scripts/levantar.sh` reconstruye todo y `./scripts/grype.sh` lo verifica).
- `pip` de la imagen base (Medium/Low). Los servicios instalan con uv, no con pip.

Snyk queda para el final, con la cuenta de la facultad (es web).

## Hallazgos de la integración

- **Vulnerabilidades corregidas** (Grype, ver arriba), cada una en una rama del repo de su
  dueño, con la suite en verde:
  - `Extraccion-de-texto-pdf-` (`fix/imagen-base-debian13`): base `python:3.11-slim`
    (Debian 13) en lugar de `uv:python3.11-bookworm-slim` (Debian 12, 16 Critical), y sin
    `setuptools`/`wheel` en el Python base. Imagen `1.0.2`.
  - `persistencia-actualizaciones` (`fix/imagen-sin-setuptools`): base `python:3.12-slim`,
    que no trae `setuptools`/`wheel`. Suite de 164 tests (con MongoDB y Redis reales) en
    verde con 3.12. Imagen `1.0.1`.
  - `validacion-pdf` (`fix/dependencias-vulnerables`): sin `python-multipart` (no se usaba),
    `starlette` 0.47.3 → 1.7.0, `pydantic-settings` 2.14.0 → 2.14.2 y `.dockerignore` nuevo
    (antes entraba `app/__pycache__` en la imagen). Imagen `1.0.1`.
  - `persistencia-consultas` (`fix/pymongo-vulnerable`): `pymongo` 4.18.1 → 4.18.2.
    Imagen `1.0.1`.
- **Fechas del orquestador con microsegundos.** `POST /pdf` devolvía `created_at` como
  `…47.787000Z`, mientras actualizaciones y consultas devuelven `…47.787Z` (A15). Se arregló
  con TDD en la rama `fix/fechas-milisegundos` de Orquestador: dos commits rojos y el
  arreglo. De ahí sale la imagen `orquestador:1.0.1`.

## Decisiones y respuestas del profesor (2026-10-07)

Preguntas que llevamos a la clase, la respuesta y qué cambió en el proyecto.

| Pregunta | Respuesta del profesor | En el proyecto |
|---|---|---|
| ¿Qué escenario usa para la prueba de carga? ¿El `409` de un PDF repetido cuenta como válido? | vegeta con **10 000 peticiones**; el PDF repetido **es válido**. | El `409` ya se contaba como correcto (pasa por validación y extracción completas). **Hecho:** 10 020 peticiones a 30/s, 115 ms promedio, 0 errores (ver [vegeta](#prueba-de-carga-vegeta)). |
| Docker reparte extracción por conexión y con pocos clientes una réplica queda ociosa. ¿Ruteamos extracción por Traefik aunque no sea pública? | Traefik tiene que balancearlo automáticamente; probar **con y sin cortocircuito**. | **Hecho:** `traefik-interno`, sin puertos publicados; reparto parejo y 37 PDF/s con 5 VUs contra 17 directo. Medido con y sin cortocircuito (ver [Balanceo](#balanceo-de-extracción-con-traefik-interno-contrato-120)). |
| Con Redis caído el cliente no tenía timeout de conexión. ¿Timeout por variable o fijo en el código? | Sí hay que ponerle timeout, y el **`/health` tiene que verificar si Redis funciona**. | Timeout corto en los dos servicios de persistencia. **Hecho:** `/health` informa MongoDB y Redis (ver [`/health` con dependencias](#health-con-dependencias)). |
| Si Redis se cae y vuelve, ¿hay que recuperar los datos viejos? | No: si Redis se cae no hay por qué conservar los datos. La caché igual se termina borrando. | Ya resuelto: Redis corre sin persistencia y arranca vacío. |

### Por qué no se guarda el PDF

El sistema guarda solo el texto extraído y los metadatos; el binario no se persiste (contrato,
modelo común). Además del tema legal, con el tiempo se acumulan muchos PDF y el volumen crece
mucho. Si hiciera falta guardarlos, lo correcto no es una carpeta del contenedor ni MongoDB sino
un **object storage**: guarda objetos (binarios, JSON, lo que sea) identificados por clave y con
**etiquetas** en lugar de carpetas, y es más eficiente para compartir archivos que una base de
datos (es lo que se usa en la nube). Queda fuera del alcance.

### Por qué MongoDB no va dentro del microservicio

MongoDB corre en su propio contenedor, con volumen nombrado, y los servicios se conectan por
`MONGO_URI` (12-Factor IV y VI). Si la base fuera parte del microservicio, al escalar a 3 réplicas
habría 3 bases distintas, cada una con datos diferentes. Por eso los procesos son sin estado y el
estado vive en un servicio de apoyo compartido.

### Patrones de microservicios que usa el proyecto

| Patrón | Dónde |
|---|---|
| **SAGA orquestada** | Una "transacción" que cruza servicios no puede usar una transacción de base de datos. El orquestador ejecuta los pasos (validar → extraer → guardar) y, si el alta queda incierta, ejecuta una **compensación** (borrar lo que se creó). Es idempotente y queda en los logs. |
| **API Gateway / proxy inverso** | Traefik: única entrada pública, TLS, ruteo por `Host`. |
| **Balanceo de carga y cortocircuito** | Traefik reparte entre réplicas y aplica el *circuit breaker*; el código solo reintenta (`RETRY_ATTEMPTS`). |
| **Descubrimiento de servicios** | Traefik lee los contenedores y sus labels desde Docker; dentro de `redutn` los servicios se encuentran por nombre (DNS de Docker). |
| **Cache-aside** | `persistencia-consultas`: busca en Redis, si no está consulta MongoDB y lo guarda. |
| **CQRS (separación lectura/escritura)** | Un servicio solo escribe (`persistencia-actualizaciones`) y otro solo lee (`persistencia-consultas`). |
| **Health check** | `GET /health` en todos; Docker y `depends_on: service_healthy` lo usan. |
| **Correlation ID (traza)** | `X-Correlation-ID` viaja por todos los servicios y aparece en cada línea de log. |
| **Repository y puertos/adaptadores** | En cada servicio: el negocio depende de abstracciones; MongoDB, Redis y los clientes HTTP son adaptadores. |

### Observabilidad: logs, trazas y métricas

- **Logs (obligatorio, 12-Factor XI):** a `stdout`, niveles `DEBUG`/`INFO`/`WARNING`/`ERROR`,
  configuración en un `logging.json` por repo y sin datos sensibles. Qué va en cada nivel está
  en el [contrato](CONTRATO.md#logs). **Hecho en los cinco servicios.** Cada uno registra
  en `INFO` su paso del flujo: validación aceptada (`tamano_bytes`), texto extraído
  (`paginas`, `checksum`), documento creado (`id`), caché `HIT`/`MISS`. Ningún log tiene el
  nombre del archivo, el texto ni el Base64: se comprobó subiendo `demo-de-juan-perez.pdf` y
  buscando `juan-perez` en `docker compose logs` (0 resultados).

  Recorrido real de un `POST /pdf` (2026-10-07, `docker compose logs | grep <id>`, ordenado):

  ```text
  orquestador      INFO ... correlation_id=75c93b70-... validacion aceptada
  validacion-pdf   INFO ... correlation_id=75c93b70-... pdf valido tamano_bytes=11378
  extraccion-texto INFO ... correlation_id=75c93b70-... texto extraido paginas=10 tamano_bytes=11378 caracteres=36839 checksum=7e72f0...
  orquestador      INFO ... correlation_id=75c93b70-... texto extraido paginas=10 checksum=7e72f0...
  actualizaciones  INFO ... correlation_id=75c93b70-... documento creado id=13f4459b-... checksum=7e72f0...
  orquestador      INFO ... correlation_id=75c93b70-... documento creado id=13f4459b-... checksum=7e72f0...
  orquestador      INFO ... correlation_id=75c93b70-... method=POST path=/pdf status=201 duracion_ms=117.1
  ```
- **Trazas:** con réplicas no se sabe qué instancia atendió cada paso; el `correlation_id` es el
  identificador único de cada petición y permite seguirla por todos los servicios:
  `docker compose logs | grep <correlation_id>`. Ya implementado.
- **Métricas** (uso de CPU y memoria) y el stack de búsqueda y paneles (Elasticsearch, un
  recolector y Grafana): el profesor los mostró pero **no son obligatorios**; no se implementan.
  Para la carga alcanza `docker stats` durante la prueba.

### Finalización segura (12-Factor IX)

Al detener un contenedor Docker manda `SIGTERM` y, si no termina a tiempo, `SIGKILL`. Si el
proceso muere con requests en curso, el cliente se queda sin respuesta y puede quedar una
escritura a medias. El contrato 1.2.0 fija qué hace cada servicio: dejar de aceptar conexiones,
terminar lo que está en curso, cerrar las conexiones y salir con código 0, todo registrado en
los logs. En el compose, `stop_grace_period: 40s` en los cinco servicios.

**Hecho en los cinco servicios** (`--timeout-graceful-shutdown 30`, cierre de httpx, MongoDB
y Redis en el `lifespan`) y probado:

- Extracción sola: extracción de 18 s y `docker stop -t 40` a los 4 s → la request termina con
  `200`, una conexión nueva se rechaza, `ExitCode` 0 y en los logs `Shutting down` → la
  extracción termina → `apagado iniciado` → `apagado completo`.
- En el stack: `docker stop` de una réplica de extracción con 5 VUs de carga → 100 % de checks,
  `ExitCode` 0 (ver [Balanceo](#balanceo-de-extracción-con-traefik-interno-contrato-120)).
- Todo el stack: `docker compose stop` de los cinco servicios (7 contenedores) → los 7 con
  `ExitCode` 0 y `apagado completo` en su log.

### `/health` con dependencias

Las dos persistencias consultan MongoDB y Redis en `/health` (contrato 1.2.0). Probado en el
stack (2026-10-07):

| Situación | `persistencia-actualizaciones` y `persistencia-consultas` |
|---|---|
| Todo arriba | `200 {"status":"ok","dependencias":{"mongodb":"ok","redis":"ok"}}` en ~8 ms |
| Redis detenido | `200 {"status":"ok","dependencias":{"mongodb":"ok","redis":"caido"}}`: siguen funcionando (fail-open) |
| MongoDB detenido | `503 {"status":"error","dependencias":{"mongodb":"caido","redis":"ok"}}` en 1,0 s; `POST /pdf` del orquestador → `503` |

Validación, extracción y el orquestador no tienen servicios de apoyo y responden
`{"status": "ok"}`.

### Swagger

Cada servicio expone la documentación interactiva de FastAPI en `/docs` (Swagger UI) y el
esquema en `/openapi.json`. El del orquestador se abre desde el host en
`https://pdf.universidad.localhost/docs`; los internos solo se alcanzan dentro de `redutn`.

### `depends_on`

El profesor advirtió que `depends_on` solo no alcanza: el contenedor puede estar arrancado y el
puerto todavía cerrado. Acá se usa `depends_on` con `condition: service_healthy`, que espera a
que el `/health` del servicio responda.

## Deuda técnica

- **Consultas tardaba 4 s por request con Redis caído:** **resuelto** (2026-10-07, PR #18
  de consultas): timeout corto del cliente Redis, 1,0 s por request.
- **Datos viejos en caché al volver Redis** (A9): **resuelto** (2026-10-07). Redis guardaba
  un snapshot al apagarse y, si mientras estuvo caído hubo una escritura, al volver devolvía el
  listado viejo hasta que vencía `REDIS_TTL_SECONDS` (se comprobó: 217 s). Ahora Redis corre
  sin persistencia (`--save ""`, `--appendonly no`) y sin volumen: es solo caché, no tiene
  estado que deba sobrevivir a un reinicio (12-Factor VI), así que arranca vacío. Queda la
  ventana mientras Redis está caído *y no se reinicia* (por ejemplo, una partición de red),
  acotada por el TTL.
- **Orquestador fuera de Traefik al saturarse.** Con más carga que capacidad, su healthcheck
  (timeout 2 s, 3 reintentos) falla, Docker lo marca `unhealthy` y Traefik lo saca (`404`).
  Se podría dar más margen al healthcheck; la solución real es no superar ~35/s o sumar
  réplicas.
- **Extracciones perdidas con `SIGKILL`.** Si una réplica muere sin `SIGTERM`, sus requests en
  curso se recuperan por timeout (10 s) y reintento.
- **Vulnerabilidades de las imágenes:** **resuelto** lo que tenía arreglo (ver Grype). Quedan
  las High de Debian 13 sin arreglo publicado.
- **Extracción sigue trabajando después de un timeout.** El orquestador corta y reintenta,
  pero el servidor no cancela la extracción en curso: bajo carga, un timeout multiplica por
  `RETRY_ATTEMPTS + 1` el trabajo de extracción. Conviene un `REQUEST_TIMEOUT_SECONDS` con
  margen sobre el p95 medido.
- **Consultas no registraba si fue HIT o MISS:** **resuelto** en `persistencia-consultas:1.0.2`
  (`cache HIT`/`cache MISS` en `INFO`).
- **Tiempo de extracción con el header:** medido con `orquestador:1.0.3` y PDFs nuevos
  (semilla `n`, 1 VU): `tiempo_extraccion_ms` 110 ms promedio (10 altas), total 147 ms. El
  header solo viene en los `201`: con PDFs repetidos (`409`) la extracción se ve en el log de
  `extraccion-texto` (`duracion_ms`).
- **El orquestador puede pasar los 30 s de gracia** en su peor caso (tres intentos de 10 s):
  si el apagado lo corta, el documento queda guardado completo y reenviar el PDF da `409`.
- **Sin métricas ni paneles** (Grafana, Elasticsearch): opcionales según el profesor.
