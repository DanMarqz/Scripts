# Cambiar al directorio actual
Set-Location -Path (Get-Location)

Write-Host "  ~~~~>_ Mostrando estatus del commit..." -ForegroundColor Cyan
Write-Host "git status" -ForegroundColor Cyan
git status
Write-Output ""

# Solicitar los inputs al usuario
$commit_file = Read-Host "  ~~~~>_  Por favor, indique los archivos a agregar al commit (. para todos)"
$commit_message = Read-Host "  ~~~~>_  Por favor, indique un mensaje para el commit"
$commit_branch = Read-Host "  ~~~~>_  Por favor, indique la rama donde se enviará su commit: $(git branch --show-current)"

# Construir los comandos
$add_files = "git add $commit_file"
$add_message = "git commit -m '$commit_message'"
$send_push = "git push -u origin $commit_branch"
Write-Output ""

# Ejecutar los comandos

Write-Host "  ~~~~>_  Agregando archivos...  " -ForegroundColor Magenta
Write-Host $add_files -ForegroundColor Magenta
Invoke-Expression $add_files
Write-Output ""

Write-Host "  ~~~~>_  Agregando mensaje...  " -ForegroundColor Yellow
Write-Host $add_message -ForegroundColor Yellow
Invoke-Expression $add_message
Write-Output ""

Write-Host "  ~~~~>_  Enviando commit...  " -ForegroundColor Cyan
Write-Host "$send_push $commit_branch" -ForegroundColor Cyan
Invoke-Expression $send_push
Write-Output ""