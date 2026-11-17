# Taller 5 — MongoDB con Compose

Arranco MongoDB con `docker compose up -d`. Para entrar uso `docker compose exec mongo mongosh -u admin -p lab_password --authenticationDatabase admin university`. Ya dentro puedo revisar `db.students.find()` y `db.courses.find()`. Si hago `docker compose down -v`, también se borra el volumen con los datos.
