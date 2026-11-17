# Rutas de la API

La aplicación queda disponible en `http://localhost:8080`. Estas son las rutas principales:

- `GET /health`
- `GET/POST /empleados` y `GET /empleados/{id}`
- `GET/POST /equipos` y `GET/PUT /equipos/{id}`
- `POST /equipos/{id}/asignar`
- `POST /equipos/{id}/mantenimientos`
- `GET /equipos/{id}/historial`
- `POST /equipos/{id}/documentos` (requiere S3; el archivo va en el campo `file`)
- `GET /equipos/{id}/documentos`

## Ejemplos para probar

```bash
curl localhost:8080/health
curl localhost:8080/equipos
curl -X POST localhost:8080/empleados -H 'Content-Type: application/json' -d '{"nombre":"María Rojas","correo":"maria@example.com","departamento":"TI"}'
curl -X POST localhost:8080/equipos -H 'Content-Type: application/json' -d '{"codigo_interno":"LAP-0030","tipo":"Laptop","marca":"HP","modelo":"ProBook"}'
curl -X POST localhost:8080/equipos/1/asignar -H 'Content-Type: application/json' -d '{"empleado_id":1}'
curl -X POST localhost:8080/equipos/1/mantenimientos -H 'Content-Type: application/json' -d '{"tipo":"Preventivo","descripcion":"Limpieza y actualización","costo":120000}'
curl localhost:8080/equipos/1/historial
```
