# Taller 3 — Flask balanceado con PostgreSQL

Acá hay tres APIs Flask que comparten la misma base de datos PostgreSQL. Levanto todo con Compose y pruebo `http://localhost:8082/products`. El campo `served_by` deja ver qué instancia respondió. También puedo agregar un producto con el ejemplo de `curl` que está abajo en el taller.

```bash
curl -X POST localhost:8082/products -H 'Content-Type: application/json' -d '{"name":"Teclado","price":85000}'
```
