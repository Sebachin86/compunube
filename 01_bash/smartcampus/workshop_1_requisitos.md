# SmartCampus — Workshop 1: requisitos
## Problema
Centralizar aulas, ocupación, reservas y alertas del campus.
## Actores
Estudiante, docente, administrador, sensor IoT y servicio de notificaciones.
## Requisitos funcionales
1. Autenticar usuarios y aplicar roles.
2. Consultar edificios, aulas y capacidad.
3. Consultar ocupación reportada por sensores.
4. Reservar/cancelar aulas evitando solapamientos.
5. Registrar telemetría con fecha y aula.
6. Generar alertas de ocupación anómala.
7. Consultar historial y reportes.
## Requisitos no funcionales
Seguridad HTTPS/RBAC; disponibilidad; respuesta objetivo menor a 2 s en consultas normales; escalabilidad horizontal; logs estructurados; minimización de datos personales.
## Criterios de aceptación
No permitir reservas solapadas; mostrar antigüedad de la última lectura; impedir que usuarios no administradores modifiquen aulas.
