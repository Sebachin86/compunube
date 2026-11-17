#!/usr/bin/env bash
set -Eeuo pipefail
[[ $# -ge 1 ]] || { echo "Uso: $0 archivo" >&2; exit 2; }
[[ -f "$1" ]] || { echo "No existe: $1" >&2; exit 2; }
f="$1"
echo "Archivo: $f"
echo "Líneas: $(wc -l < "$f")"
echo "Palabras: $(wc -w < "$f")"
echo "Caracteres: $(wc -m < "$f")"
echo "ERROR: $(grep -c ERROR "$f" || true)"
echo "WARN: $(grep -c WARN "$f" || true)"
