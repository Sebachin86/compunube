#!/usr/bin/env bash
set -Eeuo pipefail
# Primero ubico esta carpeta para que el script funcione aunque lo ejecute desde otro lado.
ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$ROOT/data" "$ROOT/output"
cat > "$ROOT/data/events.jsonl" <<'EOF'
{"service":"api","status":200,"message":"ok"}
{"service":"api","status":500,"message":"database timeout"}
{"service":"web","status":500,"message":"upstream error"}
{"service":"api","status":500,"message":"connection refused"}
{"service":"worker","status":503,"message":"queue unavailable"}
{"service":"web","status":200,"message":"ok"}
EOF
command -v jq >/dev/null || { echo "Instala jq para procesar JSON." >&2; exit 1; }
jq -c 'select(.status >= 400)' "$ROOT/data/events.jsonl" > "$ROOT/output/errors.jsonl"
jq -r 'select(.status == 500) | [.service,.status,.message] | @tsv' "$ROOT/data/events.jsonl" > "$ROOT/output/http500.tsv"
jq -s 'map(select(.status >= 400)) | length' "$ROOT/data/events.jsonl" > "$ROOT/output/error_count.txt"
jq -s 'map(select(.status == 500)) | group_by(.service) | map({service:.[0].service,count:length}) | sort_by(-.count)' "$ROOT/data/events.jsonl" > "$ROOT/output/errors_by_service.json"
ps -eo user,pid,pcpu,pmem,comm --sort=-pcpu | head -n 11 > "$ROOT/output/processes.txt"
cat "$ROOT/output/errors_by_service.json"
