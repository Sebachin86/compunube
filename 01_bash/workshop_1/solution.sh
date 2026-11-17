#!/usr/bin/env bash
set -Eeuo pipefail
# Primero ubico esta carpeta para que el script funcione aunque lo ejecute desde otro lado.
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
W="$ROOT/workspace"
mkdir -p "$W/documentos" "$W/ventas" "$W/temporal"
printf 'id,producto,cantidad\n1,Teclado,12\n2,Mouse,20\n3,Monitor,5\n' > "$W/ventas/ventas.csv"
printf 'Notas del laboratorio Bash\n' > "$W/documentos/notas.txt"
cp "$W/ventas/ventas.csv" "$W/documentos/"
mv "$W/documentos/ventas.csv" "$W/documentos/ventas_backup.csv"
echo "Directorio: $W"
ls -la "$W"
echo "Árbol:"
find "$W" -maxdepth 3 -print | sort
