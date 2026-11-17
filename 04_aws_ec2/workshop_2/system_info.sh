#!/usr/bin/env bash
set -Eeuo pipefail
hostnamectl 2>/dev/null || hostname
id
date --iso-8601=seconds
nproc
free -h
df -h /
ps -eo pid,ppid,user,%cpu,%mem,comm --sort=-%cpu | head -n 10
systemctl --failed --no-pager || true
