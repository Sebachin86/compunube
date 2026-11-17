#!/usr/bin/env bash
set -Eeuo pipefail
# Primero ubico esta carpeta para que el script funcione aunque lo ejecute desde otro lado.
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$ROOT/data" "$ROOT/output"
cat > "$ROOT/data/server.log" <<'EOF'
2026-11-01 INFO api usuario=ana ip=10.0.0.4
2026-11-01 ERROR api usuario=luis ip=10.0.0.8 timeout
2026-11-02 WARN web usuario=ana ip=10.0.0.4 latency
2026-11-02 ERROR db usuario=sofia ip=10.0.0.9 connection
2026-11-03 INFO web usuario=luis ip=10.0.0.8 ok
EOF
grep ERROR "$ROOT/data/server.log" > "$ROOT/output/errors.txt"
grep -c ERROR "$ROOT/data/server.log" > "$ROOT/output/error_count.txt"
awk '{print $3}' "$ROOT/data/server.log" | sort | uniq -c | sort -nr > "$ROOT/output/by_service.txt"
cut -d' ' -f1-3 "$ROOT/data/server.log" > "$ROOT/output/summary.txt"
find "$ROOT/data" -type f -name '*.log' > "$ROOT/output/log_files.txt"
chmod 640 "$ROOT/data/server.log"
cat "$ROOT/output/errors.txt"
echo "Resultados: $ROOT/output"
