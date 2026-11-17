# SmartCampus — Workshop 3: datos y plan
## Modelo
`users(id,name,email,role)`, `buildings(id,name)`, `rooms(id,building_id,code,capacity)`, `reservations(id,room_id,user_id,starts_at,ends_at,status)`, `sensor_readings(id,room_id,occupancy,recorded_at)`, `alerts(id,room_id,type,message,created_at,resolved_at)`.
La prevención de doble reserva debe realizarse en una transacción y reforzarse con una restricción temporal en PostgreSQL.
## Pruebas
Unitarias de reglas y roles; integración API+DB; contrato JSON; seguridad; carga.
## Riesgos
Sensor desconectado: marcar lectura obsoleta. Doble reserva: transacción. Caché perdida: reconstruir desde DB. API caída: réplicas detrás de balanceador.
## Fases
MVP de usuarios/aulas; reservas; sensores; alertas; contenedores; observabilidad y pruebas de carga.
