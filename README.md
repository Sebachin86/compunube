# compunube ☁️

Este es mi repositorio para la clase de **Computación en la Nube**. Acá voy dejando los talleres y las soluciones que fui armando, cada cosa en su carpeta para no revolver todo.

**GitHub:** https://github.com/Sebachin86/compunube

## Mi entorno

- Windows 11
- Usuario de Windows: `PC`
- Carpeta: `C:\Users\PC\Documents\compunube`
- VS Code y PowerShell
- Docker y Python instalados
- Para los ejercicios de Bash voy a usar Ubuntu con WSL 2.

## ¿Qué hay por acá?

| Carpeta | Qué tiene |
|---|---|
| `01_bash/` | Talleres de Bash y el ejercicio de SmartCampus |
| `02_bash/` | Logs, Dockerfile, CMD, ENTRYPOINT, Compose y Nginx |
| `03_docker/` | Flask, Nginx, proxy inverso, balanceo y bases de datos |
| `04_aws_ec2/` | Los seis talleres de EC2 |
| `05_cloud/` | Aplicación para llevar el control de equipos, con Flask y PostgreSQL |
| `docs/` | Guías y notas para trabajar desde Windows |
| `scripts/` | Un diagnóstico rápido del equipo |

## Sobre los talleres de comandos

En Bash y en los ejercicios de terminal dejé sobre todo el **resultado**: carpetas, archivos, respaldos y reportes. No tiene mucho sentido llenar el repo con una lista eterna de comandos si lo que importa es que quede hecho. Algunos scripts están por si toca repetir el proceso o mostrar cómo se generó algo.

Cuando una salida sea de ejemplo, lo digo. Si el profe pide evidencia de mi computador o de AWS, esa sí toca sacarla ejecutando el taller; no voy a poner capturas inventadas.

## Abrirlo en mi PC

1. Descomprimir la carpeta `compunube` dentro de `C:\Users\PC\Documents\`.
2. Abrir VS Code y seleccionar **File → Open Folder**.
3. Escoger `C:\Users\PC\Documents\compunube`.
4. Abrir **Terminal → New Terminal** y usar PowerShell.
5. Para empezar, mirar `docs/windows-vscode.md`.

## Ojo con AWS

Los archivos y las guías para EC2/ECR/S3 están preparados, pero los recursos reales se crean desde una cuenta AWS. Antes de terminar, revisar los costos y borrar lo que ya no se vaya a usar.

Tampoco subir claves `.pem`, contraseñas, tokens ni archivos `.env`. Para eso están las plantillas `.env.example`.

**El proyecto final que estaba en `project/` va aparte**, así que no lo metí en este repo.
