# Taller 4 — Seguridad de red

Esta es la idea de cómo dejar los puertos: SSH solo desde la IP administrativa, HTTP/HTTPS según lo que vaya a publicar, y Flask/PostgreSQL sin acceso público directo. Si la API y la base están en la misma red privada, no hace falta abrir esos puertos a todo Internet.

| Puerto | Servicio | Acceso recomendado |
|---|---|---|
| 22/TCP | SSH | Mi IP administrativa o Session Manager |
| 80/TCP | HTTP | Público si la página lo necesita |
| 443/TCP | HTTPS | Público si la página lo necesita |
| 5000/TCP | Flask | Solo desde Nginx |
| 5432/TCP | PostgreSQL | Solo desde la aplicación |

