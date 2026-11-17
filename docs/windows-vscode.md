# Cómo trabajar desde Windows 11

Esta guía es para abrir y probar el repo desde mi PC, usando VS Code y PowerShell.

## Lo que tengo configurado

- Usuario: `PC`
- Carpeta: `C:\Users\PC`
- Editor: VS Code
- Terminal: PowerShell
- Docker Desktop y Python instalados
- El nombre del equipo todavía está pendiente de revisar.

## 1. Abrir la carpeta

La ruta que voy a usar es:

```text
C:\Users\PC\Documents\compunube
```

En VS Code entro a **File → Open Folder**, busco esa carpeta y la abro. Después voy a **Terminal → New Terminal** y reviso que diga PowerShell.

## 2. Revisar qué herramientas están funcionando

En la terminal ejecuto:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\diagnostico-windows.ps1
```

Ese cambio de política solo aplica a esa ventana de PowerShell.

## 3. Revisar Docker

Abro Docker Desktop y espero a que termine de iniciar. Luego pruebo:

```powershell
docker --version
docker compose version
docker info
```

Si `docker info` dice que no puede conectarse al motor, seguramente Docker Desktop todavía está arrancando o no quedó iniciado.

## 4. Revisar Python

```powershell
py --version
python --version
```

Para crear un entorno virtual dentro de un taller:

```powershell
cd .\03_docker\workshop_1
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
```

Cuando termine, salgo del entorno con `deactivate`.

## 5. Bash con WSL 2

Los talleres Bash usan comandos de Linux, así que lo más cómodo en Windows es tener Ubuntu con WSL 2. Primero reviso:

```powershell
wsl --status
wsl --list --verbose
```

Si todavía no está instalado y tengo permisos de administrador:

```powershell
wsl --install -d Ubuntu
```

Si Windows pide reiniciar, lo hago. Después, desde Ubuntu, puedo entrar al repo así:

```bash
cd /mnt/c/Users/PC/Documents/compunube
bash 01_bash/workshop_1/solution.sh
```

También puedo instalar la extensión WSL de Microsoft en VS Code para abrir la carpeta desde Ubuntu.

## 6. Usar Docker Compose

Me ubico en la carpeta del taller donde está el archivo `docker-compose.yml` y ejecuto, por ejemplo:

```powershell
docker compose up --build -d
docker compose ps
```

Para detenerlo:

```powershell
docker compose down
```

Ojo: `docker compose down -v` también borra los volúmenes y con ellos los datos de la base de datos de ese taller. Lo uso solo si de verdad quiero empezar desde cero.

## 7. Variables y contraseñas

Cuando un taller tenga `.env.example`, hago una copia llamada `.env` y pongo mis propios valores. El `.env` no se sube a GitHub. Nunca subo claves privadas, contraseñas ni tokens.

## 8. Un detalle

Los comandos Bash se ejecutan en Ubuntu/WSL, mientras que los comandos de Docker y Git se pueden ejecutar desde PowerShell. Si algo falla, guardo el mensaje completo para revisar qué pasó.
