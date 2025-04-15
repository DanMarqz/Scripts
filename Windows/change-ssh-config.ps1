# Copia el directorio actual y lo guarda en una variable
$original_directory = Get-Location
# Cambiar al directorio princiapl de ssh
Set-Location -Path ~/.ssh

# Logica para eliminar el archicho "config" si existe en ~/.ssh, si no existe dar mensaje de que no existe
Get-Location
if (Test-Path -Path "config") {
    Write-Host "  ~~~~>_  Eliminando archivo config...  " -ForegroundColor Magenta
    Remove-Item -Path "config"
    Write-Host ""
} else {
    Write-Host "  ~~~~>_  No existe el archivo config en ~/.ssh" -ForegroundColor Yellow
    Write-Host ""
}

# Logica en donde el programa le pregunta al usuario cual configuracion desea tener, si "config-work" o "config-personal". El usuario debe mover con las flechas arriba o abajo para seleccionar su opcion.
$ssh_config = @("~> (1) config-work", "~> (2) config-personal")
$ssh_config | ForEach-Object {
    Write-Host "  ~~~~>_  $_" -ForegroundColor Cyan
}
$selected_config = Read-Host "  ~~~~>_  Por favor, seleccione la configuracion deseada (config-work o config-personal)"
if ($selected_config -eq 1) {
    Write-Host "  ~~~~>_  Copiando archivo config-work a config...  " -ForegroundColor Magenta
    Copy-Item -Path "config-work" -Destination "config"
    Write-Host ""
} elseif ($selected_config -eq 2) {
    Write-Host "  ~~~~>_  Copiando archivo config-personal a config...  " -ForegroundColor Magenta
    Copy-Item -Path "config-personal" -Destination "config"
    Write-Host ""
} else {
    Write-Host "  ~~~~>_  Opcion no valida. Por favor, seleccione config-work o config-personal" -ForegroundColor Red
}

# Mensaje de despedida al usuario
Write-Host "  ~~~~>_  Configuracion de SSH actualizada exitosamente!" -ForegroundColor Green
Set-Location $original_directory