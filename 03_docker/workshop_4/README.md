# Taller 4 — PostgreSQL con Compose

Arranco la base con `docker compose up -d`. Para entrar uso `docker compose exec db psql -U university -d university`. Los scripts de `init/` se ejecutan cuando el volumen se crea por primera vez. Si uso `docker compose down -v`, se borra también el volumen y sus datos.
