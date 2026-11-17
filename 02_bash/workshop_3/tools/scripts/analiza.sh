#!/usr/bin/env bash
set -Eeuo pipefail
f="${1:-/logs/monitor.log}"
[[ -f "$f" ]] || { echo "No existe $f" >&2; exit 2; }
echo "Registros: $(wc -l < "$f")"
