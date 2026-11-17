# Taller 1 — Flask con balanceo en Nginx

Levanto todo con `docker compose up --build -d` y abro `http://localhost:8080`. Si actualizo varias veces, el campo `served_by` me muestra cuál de las tres APIs respondió. También puedo detener `api2` con `docker compose stop api2` y volver a probar.
