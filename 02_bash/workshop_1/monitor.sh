#!/usr/bin/env bash
set -Eeuo pipefail
echo "Hostname: $(hostname)"
echo "Usuario: $(whoami)"
echo "Fecha: $(date --iso-8601=seconds)"
echo "Directorio: $(pwd)"
df -h /
echo "Procesos activos: $(ps -e --no-headers | wc -l)"
echo "Diagnóstico finalizado."
