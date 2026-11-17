#!/usr/bin/env bash
set -Eeuo pipefail
# Primero ubico esta carpeta para que el script funcione aunque lo ejecute desde otro lado.
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SRC="${1:-$ROOT/sample}"
STAMP="$(date +%Y%m%d_%H%M%S)"
[[ -d "$SRC" ]] || { echo "No existe el directorio: $SRC" >&2; exit 2; }
DEST="$ROOT/backups/$STAMP"
mkdir -p "$DEST"
count=0
while IFS= read -r -d '' f; do cp -- "$f" "$DEST/"; ((count+=1)); done < <(find "$SRC" -maxdepth 1 -type f -name '*.txt' -print0)
ARCHIVE="$ROOT/backups/backup_${STAMP}.tar.gz"
tar -czf "$ARCHIVE" -C "$(dirname "$SRC")" "$(basename "$SRC")"
printf 'Fecha: %s\nOrigen: %s\nTXT copiados: %s\nArchivo: %s\nEstado: éxito\n\n' "$(date --iso-8601=seconds)" "$SRC" "$count" "$ARCHIVE" >> "$ROOT/backup.log"
echo "Backup completado: $ARCHIVE (TXT: $count)"
