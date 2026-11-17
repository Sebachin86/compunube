#!/usr/bin/env bash
set -Eeuo pipefail
case "${1:-}" in
 --info) echo "ubuntu-bash-lab"; id; echo "Bash $BASH_VERSION" ;;
 --help) echo "Uso: docker run ubuntu-bash-lab [--info|--help]" ;;
 *) echo "Argumento no reconocido: $1" >&2; exit 2 ;;
esac
