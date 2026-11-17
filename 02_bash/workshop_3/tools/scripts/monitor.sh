#!/usr/bin/env bash
set -Eeuo pipefail
echo "timestamp=$(date -Iseconds) host=$(hostname) processes=$(ps -e --no-headers | wc -l)"
