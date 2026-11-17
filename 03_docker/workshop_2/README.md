# Taller 2 — Reverse proxy por rutas

Levanto los servicios y pruebo `http://localhost:8081/users/` y `http://localhost:8081/products/`. Nginx manda cada ruta a una API diferente. Esto es reverse proxy; no es balanceo porque cada ruta tiene un solo servicio detrás.
