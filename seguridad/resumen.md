# Resumen de Grype

Generado el 2026-11-09 con `scripts/grype.sh`.

| Imagen | Critical | High | Medium | Low | Negligible | Unknown | Total | Con arreglo | De Python |
|---|---|---|---|---|---|---|---|---|---|
| `extraccion-texto:1.3.1` | 2 | 61 | 74 | 13 | 50 | 0 | 200 | 22 | 10 |
| `orquestador:1.2.0` | 0 | 61 | 71 | 13 | 50 | 0 | 195 | 17 | 6 |
| `persistencia-actualizaciones:1.1.0` | 2 | 65 | 71 | 13 | 50 | 0 | 201 | 23 | 12 |
| `persistencia-consultas:1.1.0` | 0 | 65 | 71 | 13 | 50 | 0 | 199 | 21 | 10 |
| `validacion-pdf:1.2.0` | 2 | 61 | 73 | 13 | 50 | 0 | 199 | 21 | 10 |

## Critical y High

| Imagen | Severidad | Vulnerabilidad | Paquete | Versión con arreglo |
|---|---|---|---|---|
| `extraccion-texto:1.3.1` | Critical | GHSA-6q48-6c7w-9gw2 | `certifi` 2026.7.22 (python) | 2026.10.18 |
| `extraccion-texto:1.3.1` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-119373 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-119374 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-119379 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-76844 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-84243 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-84243 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `extraccion-texto:1.3.1` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `extraccion-texto:1.3.1` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-119373 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-119374 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-119379 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-76844 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-84243 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-84243 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `orquestador:1.2.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.2.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | Critical | GHSA-6q48-6c7w-9gw2 | `certifi` 2026.7.22 (python) | 2026.10.18 |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-119373 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-119374 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-119379 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-76844 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-84243 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-84243 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.1.0` | High | GHSA-45c3-73f7-pv4m | `dnspython` 2.8.0 (python) | 2.9.0 |
| `persistencia-actualizaciones:1.1.0` | High | GHSA-98qm-wvgf-w4cf | `pymongo` 4.18.2 (python) | 4.18.3 |
| `persistencia-consultas:1.1.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-119373 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-119374 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-119379 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-76844 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-84243 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-84243 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `persistencia-consultas:1.1.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.1.0` | High | GHSA-45c3-73f7-pv4m | `dnspython` 2.8.0 (python) | 2.9.0 |
| `persistencia-consultas:1.1.0` | High | GHSA-98qm-wvgf-w4cf | `pymongo` 4.18.2 (python) | 4.18.3 |
| `validacion-pdf:1.2.0` | Critical | GHSA-6q48-6c7w-9gw2 | `certifi` 2026.7.22 (python) | 2026.10.18 |
| `validacion-pdf:1.2.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-119373 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-119374 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-119379 | `libsqlite3-0` 3.46.1-7+deb13u2 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-76844 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-84243 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-84243 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | 1:1.3.dfsg+really1.3.1-1+deb13u1 |
| `validacion-pdf:1.2.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.2.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
