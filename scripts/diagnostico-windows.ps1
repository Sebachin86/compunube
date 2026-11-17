$ErrorActionPreference = "Continue"

Write-Host "`n=== EQUIPO ===" -ForegroundColor Cyan
hostname
whoami

Write-Host "`n=== WINDOWS ===" -ForegroundColor Cyan
Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber

Write-Host "`n=== PERFIL Y RUTA ACTUAL ===" -ForegroundColor Cyan
$env:USERPROFILE
Get-Location

Write-Host "`n=== PYTHON ===" -ForegroundColor Cyan
py --version
python --version

Write-Host "`n=== GIT ===" -ForegroundColor Cyan
git --version

Write-Host "`n=== DOCKER ===" -ForegroundColor Cyan
docker --version
docker compose version
docker info --format 'Engine={{.ServerVersion}} OS={{.OperatingSystem}}' 2>$null

Write-Host "`n=== WSL ===" -ForegroundColor Cyan
wsl --status
wsl --list --verbose

Write-Host "`nDiagnóstico terminado. Conserva los errores para revisar herramientas que falten."
