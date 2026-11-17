#!/usr/bin/env bash
set -Eeuo pipefail
cat <<'CMDS'
docker pull ubuntu:24.04
docker pull nginx:alpine
docker run -dit --name bash-lab-ubuntu ubuntu:24.04 bash
docker run -d --name bash-lab-nginx -p 8088:80 nginx:alpine
docker ps
docker exec -it bash-lab-ubuntu bash
docker logs bash-lab-nginx
docker inspect bash-lab-nginx
docker stats --no-stream
docker stop bash-lab-ubuntu bash-lab-nginx
docker rm bash-lab-ubuntu bash-lab-nginx
CMDS
