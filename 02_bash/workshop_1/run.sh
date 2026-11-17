#!/usr/bin/env bash
set -Eeuo pipefail
# Me paso a la carpeta del taller para encontrar los archivos sin depender de dónde abrí la terminal.
cd "$(dirname "$0")"
chmod +x saludo.sh monitor.sh analiza.sh
./saludo.sh
./monitor.sh
./analiza.sh access.log | tee reporte.txt
echo "Errores por usuario:"
awk '$6=="ERROR"{c[$2]++} END{for(u in c)print c[u],u}' access.log | sort -rn
echo "IP con más errores:"
awk '$6=="ERROR"{c[$1]++} END{for(ip in c)print c[ip],ip}' access.log | sort -rn | head -1
