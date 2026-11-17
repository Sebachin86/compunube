#!/bin/bash
# Si algo falla, que el script lo muestre; así es más fácil pillar qué pasó al iniciar la EC2.
set -euxo pipefail
apt-get update
apt-get install -y nginx
systemctl enable nginx
cat > /var/www/html/index.html <<'HTML'
<!doctype html><html lang="es"><meta charset="utf-8"><h1>Servidor provisionado automáticamente</h1><p>EC2 + User Data</p></html>
HTML
systemctl restart nginx
