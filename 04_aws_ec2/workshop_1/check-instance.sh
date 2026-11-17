#!/usr/bin/env bash
set -Eeuo pipefail
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
id
ip -brief address
df -h
free -h
