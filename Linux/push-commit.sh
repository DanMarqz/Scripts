#!/bin/sh

cd $(pwd)
echo "  ~~~~>_ Mostrando estatus del commit..."
echo "git status"
eval git status
echo ""

# Solicitar los inputs al usuario
read -p "  ~~~~>_  Por favor, indique los archivos a agregar al commit (. para todos): " commit_file
read -p "  ~~~~>_  Por favor, indique un mensaje para el commit: " commit_message
read -p "  ~~~~>_  Por favor, indique la rama donde se enviara su commit: $(git branch 2> /dev/null | grep -e "^\*" | sed -E 's/\*\s+//')" commit_branch

# Construir los comandos
add_files="git add $commit_file"
add_message="git commit -m '$commit_message'" 
send_push="git push -u origin $commit_branch"
echo ""

# Ejecutar los comandos

echo "  ~~~~>_  Agregando archivos...  "
echo "$add_files"
eval $add_files
echo ""

echo "  ~~~~>_  Agregando mensaje...  "
echo "$add_message"
eval $add_message
echo ""

echo "  ~~~~>_  Enviando commit...  "
echo "$send_push $commit_branch"
eval $send_push
echo ""
