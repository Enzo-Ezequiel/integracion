# Resumen de Grype

Generado el 2026-10-07 con `scripts/grype.sh`.

| Imagen | Critical | High | Medium | Low | Negligible | Unknown | Total | Con arreglo | De Python |
|---|---|---|---|---|---|---|---|---|---|
| `extraccion-texto:1.0.0` | 16 | 136 | 145 | 27 | 81 | 16 | 421 | 163 | 10 |
| `orquestador:1.0.1` | 0 | 55 | 59 | 11 | 47 | 0 | 172 | 13 | 6 |
| `persistencia-actualizaciones:1.0.0` | 0 | 59 | 62 | 11 | 47 | 0 | 179 | 20 | 9 |
| `persistencia-consultas:1.0.0` | 0 | 61 | 67 | 16 | 47 | 0 | 191 | 32 | 12 |
| `validacion-pdf:1.0.0` | 0 | 67 | 67 | 19 | 47 | 0 | 200 | 41 | 30 |

## Critical y High

| Imagen | Severidad | Vulnerabilidad | Paquete | Versión con arreglo |
|---|---|---|---|---|
| `extraccion-texto:1.0.0` | Critical | CVE-2025-7458 | `libsqlite3-0` 3.40.1-2+deb12u2 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-12087 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-13221 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-31789 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-31789 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-33845 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-34182 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-34182 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-42010 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-42496 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-5450 | `libc-bin` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-5450 | `libc6` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-57433 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-75803 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-75803 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | Critical | CVE-2026-8376 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | High | CVE-2025-13151 | `libtasn1-6` 4.19.0-2+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2025-13836 | `python` 3.11.14 (binary) | 3.10.20, 3.11.15, 3.12.13, 3.13.11, 3.14.1, 3.15.0a3 |
| `extraccion-texto:1.0.0` | High | CVE-2025-15281 | `libc-bin` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2025-15281 | `libc6` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2025-6297 | `dpkg` 1.21.22 (deb) | 1.21.23 |
| `extraccion-texto:1.0.0` | High | CVE-2025-69720 | `libncursesw6` 6.4-4 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2025-69720 | `libtinfo6` 6.4-4 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2025-69720 | `ncurses-base` 6.4-4 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2025-69720 | `ncurses-bin` 6.4-4 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-0861 | `libc-bin` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-0861 | `libc6` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-0915 | `libc-bin` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-0915 | `libc6` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-102010 | `gcc-12-base` 12.2.0-14+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-102010 | `libgcc-s1` 12.2.0-14+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-102010 | `libstdc++6` 12.2.0-14+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-103111 | `libpcre2-8-0` 10.42-1 (deb) | 10.42-1+deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-11822 | `libsqlite3-0` 3.40.1-2+deb12u2 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-11824 | `libsqlite3-0` 3.40.1-2+deb12u2 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-11940 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.15, 3.14.7, 3.15.0b4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-11972 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.15, 3.14.7, 3.15.0b4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-15308 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.15, 3.14.7, 3.15.0b4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-19499 | `libc-bin` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-19499 | `libc6` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-2219 | `dpkg` 1.21.22 (deb) | 1.21.23 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28387 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28387 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28388 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28388 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28389 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28389 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28390 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-28390 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-31790 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-31790 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.19-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-33846 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-34180 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-34180 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-3644 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.13, 3.14.4, 3.15.0a8 |
| `extraccion-texto:1.0.0` | High | CVE-2026-3833 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40355 | `libgssapi-krb5-2` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40355 | `libk5crypto3` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40355 | `libkrb5-3` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40355 | `libkrb5support0` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40356 | `libgssapi-krb5-2` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40356 | `libk5crypto3` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40356 | `libkrb5-3` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-40356 | `libkrb5support0` 1.20.1-2+deb12u4 (deb) | 1.20.1-2+deb12u5 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4046 | `libc-bin` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4046 | `libc6` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-41992 | `gzip` 1.12-1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-42009 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-42011 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-42012 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-42013 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4224 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.13, 3.14.4, 3.15.0a8 |
| `extraccion-texto:1.0.0` | High | CVE-2026-42497 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4437 | `libc-bin` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4437 | `libc6` 2.36-9+deb12u13 (deb) | 2.36-9+deb12u14 |
| `extraccion-texto:1.0.0` | High | CVE-2026-45445 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-45445 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-45447 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-45447 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4786 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.14, 3.14.5rc1, 3.15.0b1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-4878 | `libcap2` 1:2.66-4+deb12u2+b2 (deb) | 1:2.66-4+deb12u3 |
| `extraccion-texto:1.0.0` | High | CVE-2026-48959 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-48962 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-5260 | `libgnutls30` 3.7.9-2+deb12u5 (deb) | 3.7.9-2+deb12u7 |
| `extraccion-texto:1.0.0` | High | CVE-2026-5435 | `libc-bin` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-5435 | `libc6` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-54369 | `libacl1` 2.3.1-3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-54370 | `libacl1` 2.3.1-3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-54874 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-54874 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-57432 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-5928 | `libc-bin` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-5928 | `libc6` 2.36-9+deb12u13 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-6100 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.14, 3.14.5rc1, 3.15.0b1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-63072 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-63072 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-63076 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-63076 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.22-1~deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-7017 | `perl-base` 5.36.0-7+deb12u3 (deb) | 5.36.0-7+deb12u4 |
| `extraccion-texto:1.0.0` | High | CVE-2026-7210 | `python` 3.11.14 (binary) | 3.10.22, 3.11.16, 3.12.14, 3.13.14, 3.14.6, 3.15.0b2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-7383 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-7383 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `bsdutils` 1:2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `libblkid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `libmount1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `libsmartcols1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `libuuid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `mount` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `util-linux-extra` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-76642 | `util-linux` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `bsdutils` 1:2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `libblkid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `libmount1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `libsmartcols1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `libuuid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `mount` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `util-linux-extra` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78408 | `util-linux` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `bsdutils` 1:2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `libblkid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `libmount1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `libsmartcols1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `libuuid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `mount` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `util-linux-extra` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78409 | `util-linux` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `bsdutils` 1:2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `libblkid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `libmount1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `libsmartcols1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `libuuid1` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `mount` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `util-linux-extra` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-78410 | `util-linux` 2.38.1-5+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-82049 | `python` 3.11.14 (binary) | 3.10.22, 3.11.17, 3.12.15, 3.13.16, 3.14.0b1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-82560 | `perl-base` 5.36.0-7+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-84782 | `libssl3` 3.0.18-1~deb12u2 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-84782 | `openssl` 3.0.18-1~deb12u2 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-85091 | `zlib1g` 1:1.2.13.dfsg-1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-86145 | `libpcre2-8-0` 10.42-1 (deb) | 10.42-1+deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-89157 | `libpcre2-8-0` 10.42-1 (deb) | 10.42-1+deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-89161 | `libpcre2-8-0` 10.42-1 (deb) | 10.42-1+deb12u1 |
| `extraccion-texto:1.0.0` | High | CVE-2026-9076 | `libssl3` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-9076 | `openssl` 3.0.18-1~deb12u2 (deb) | 3.0.20-1~deb12u2 |
| `extraccion-texto:1.0.0` | High | CVE-2026-9538 | `perl-base` 5.36.0-7+deb12u3 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-95619 | `gcc-12-base` 12.2.0-14+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-95619 | `libgcc-s1` 12.2.0-14+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-95619 | `libstdc++6` 12.2.0-14+deb12u1 (deb) | sin arreglo |
| `extraccion-texto:1.0.0` | High | CVE-2026-9669 | `python` 3.11.14 (binary) | 3.10.21, 3.11.16, 3.12.14, 3.13.14, 3.14.6, 3.15.0b3 |
| `extraccion-texto:1.0.0` | High | GHSA-58pv-8j8x-9vj2 | `jaraco-context` 5.3.0 (python) | 6.1.0 |
| `extraccion-texto:1.0.0` | High | GHSA-8rrh-rw8j-w5fx | `wheel` 0.45.1 (python) | 0.46.2 |
| `orquestador:1.0.1` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `orquestador:1.0.1` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-actualizaciones:1.0.0` | High | GHSA-4w2j-m93h-cj5j | `quinn-proto` 0.11.14 (rust-crate) | 0.11.15 |
| `persistencia-actualizaciones:1.0.0` | High | GHSA-58pv-8j8x-9vj2 | `jaraco-context` 5.3.0 (python) | 6.1.0 |
| `persistencia-actualizaciones:1.0.0` | High | GHSA-8rrh-rw8j-w5fx | `wheel` 0.45.1 (python) | 0.46.2 |
| `persistencia-consultas:1.0.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `persistencia-consultas:1.0.0` | High | GHSA-4w2j-m93h-cj5j | `quinn-proto` 0.11.14 (rust-crate) | 0.11.15 |
| `persistencia-consultas:1.0.0` | High | GHSA-82j2-j2ch-gfr8 | `rustls-webpki` 0.103.10 (rust-crate) | 0.103.13 |
| `persistencia-consultas:1.0.0` | High | GHSA-v4x9-3549-crwv | `pymongo` 4.18.1 (python) | 4.18.2 |
| `persistencia-consultas:1.0.0` | High | GHSA-vp6j-j7w5-5xjj | `pymongo` 4.18.1 (python) | 4.18.2 |
| `validacion-pdf:1.0.0` | High | CVE-2025-69720 | `libncursesw6` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2025-69720 | `libtinfo6` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2025-69720 | `ncurses-base` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2025-69720 | `ncurses-bin` 6.5+20250216-2 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-102010 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-102010 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-102010 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-19499 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-19499 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-5435 | `libc-bin` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-5435 | `libc6` 2.41-12+deb13u4 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-54369 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-54370 | `libacl1` 2.3.2-2+b1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-76642 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78408 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78409 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `bsdutils` 1:2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `libblkid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `liblastlog2-2` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `libmount1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `libsmartcols1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `libuuid1` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `login` 1:4.16.0-2+really2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `mount` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-78410 | `util-linux` 2.41.5-0+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-82560 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-85091 | `zlib1g` 1:1.3.dfsg+really1.3.1-1+b1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-9538 | `perl-base` 5.40.1-6+deb13u1 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-95619 | `gcc-14-base` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-95619 | `libgcc-s1` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | CVE-2026-95619 | `libstdc++6` 14.2.0-19 (deb) | sin arreglo |
| `validacion-pdf:1.0.0` | High | GHSA-4w2j-m93h-cj5j | `quinn-proto` 0.11.14 (rust-crate) | 0.11.15 |
| `validacion-pdf:1.0.0` | High | GHSA-5rvq-cxj2-64vf | `python-multipart` 0.0.26 (python) | 0.0.30 |
| `validacion-pdf:1.0.0` | High | GHSA-7f5h-v6xp-fcq8 | `starlette` 0.47.3 (python) | 0.49.1 |
| `validacion-pdf:1.0.0` | High | GHSA-82w8-qh3p-5jfq | `starlette` 0.47.3 (python) | 1.3.1 |
| `validacion-pdf:1.0.0` | High | GHSA-pp6c-gr5w-3c5g | `python-multipart` 0.0.26 (python) | 0.0.27 |
| `validacion-pdf:1.0.0` | High | GHSA-wqp7-x3pw-xc5r | `starlette` 0.47.3 (python) | 1.1.0 |
