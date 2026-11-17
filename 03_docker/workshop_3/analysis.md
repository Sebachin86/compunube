# Lo que pasa en este montaje

Los datos quedan guardados en PostgreSQL y las APIs pueden ser reemplazadas por cualquiera de las réplicas porque todas consultan la misma base. Si una API se cae, las otras pueden seguir respondiendo. Si se cae PostgreSQL, las operaciones que dependen de ella dejan de funcionar. O sea, balancear las APIs no significa que la base de datos también esté escalada. Para algo real habría que pensar en backups, alta disponibilidad, conexiones, TLS y monitoreo.
