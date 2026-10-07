// Escenario del profesor: 10 PDFs que se repiten durante DURATION contra POST /pdf.
// Desde la segunda vuelta persistencia responde 409 DUPLICATE_CHECKSUM: igual pasa
// por validación y extracción completas, así que se cuenta como respuesta correcta.
//
// Entra por el Traefik del equipo (HTTPS) y valida el certificado mkcert: hace falta su CA
// instalada (mkcert -install). En una máquina sin la CA: -e INSECURE=1. k6 (Go) no
// resuelve *.localhost en Windows: el host se apunta a TRAEFIK_IP solo dentro de la prueba.
//
// El tiempo de extracción se mide aparte del total con X-Extraction-Time-Ms, que el
// orquestador (desde la 1.0.2) reenvía en cada 201: métrica tiempo_extraccion_ms.
//
// Uso: k6 run -e VUS=5 -e DURATION=30s k6-orquestador.js
import http from "k6/http";
import encoding from "k6/encoding";
import { check } from "k6";
import { Counter, Trend } from "k6/metrics";

const HOST = __ENV.HOST || "pdf.universidad.localhost";
const TRAEFIK_IP = __ENV.TRAEFIK_IP || "127.0.0.1";
const BASE_URL = `https://${HOST}`;
const PDF_DIR = __ENV.PDF_DIR || "../pdfs";
const SEMILLA = __ENV.SEMILLA || "a";
const CANTIDAD = 10;

const pdfs = Array.from({ length: CANTIDAD }, (_, i) => {
  const nombre = `documento-${SEMILLA}-${String(i + 1).padStart(2, "0")}.pdf`;
  const archivo = open(`${PDF_DIR}/${nombre}`, "b");
  return JSON.stringify({ archivo_base64: encoding.b64encode(archivo), nombre });
});

const creados = new Counter("pdf_creados_201");
const duplicados = new Counter("pdf_duplicados_409");
const tiempoExtraccion = new Trend("tiempo_extraccion_ms", true);

export const options = {
  vus: Number(__ENV.VUS || 1),
  duration: __ENV.DURATION || "30s",
  insecureSkipTLSVerify: __ENV.INSECURE === "1",
  hosts: { [HOST]: TRAEFIK_IP },
  thresholds: {
    checks: ["rate==1.0"],
    http_req_failed: ["rate==0"],
  },
};

http.setResponseCallback(http.expectedStatuses(201, 409));

export default function () {
  const body = pdfs[(__ITER * options.vus + __VU) % CANTIDAD];
  const res = http.post(`${BASE_URL}/pdf`, body, {
    headers: { "Content-Type": "application/json" },
  });

  if (res.status === 201) {
    creados.add(1);
    const extraccion = Number(res.headers["X-Extraction-Time-Ms"]);
    if (!Number.isNaN(extraccion)) tiempoExtraccion.add(extraccion);
  }
  if (res.status === 409) duplicados.add(1);

  check(res, {
    "201 o 409": (r) => r.status === 201 || r.status === 409,
    "201 trae el texto": (r) => r.status !== 201 || r.json("texto").length > 0,
    "409 es DUPLICATE_CHECKSUM": (r) =>
      r.status !== 409 || r.json("error.code") === "DUPLICATE_CHECKSUM",
  });
}
