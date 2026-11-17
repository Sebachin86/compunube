# Taller 5 — Seguimiento de equipos

Armé una aplicación Flask para llevar empleados, equipos, asignaciones, mantenimientos e historial. PostgreSQL guarda los datos y Nginx recibe las peticiones. También dejé preparada una opción para subir documentos a S3.

## Probar en local

1. Copio `.env.example` y lo guardo como `.env`.
2. Cambio la contraseña de ejemplo por una propia.
3. Levanto todo con `docker compose up --build -d`.
4. Pruebo `http://localhost:8080/health` y `http://localhost:8080/equipos`.
5. Para ver las rutas y ejemplos, reviso `docs/API.md`.
6. Para apagar uso `docker compose down`. No uso `down -v` a menos que quiera borrar también los datos.

La guía de AWS está en `docs/DEPLOY_AWS.md`. La integración está documentada, pero los recursos reales hay que crearlos desde la cuenta AWS.
