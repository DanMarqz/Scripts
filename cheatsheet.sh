#!/bin/bash

# Nombre del archivo
cheatsheet="$HOME/Documents/cheatsheet.md"
helper="$HOME/Documents/help.md"

# Verifica si el archivo existe
if [[ ! -f $cheatsheet ]]; then
    echo "El archivo $cheatsheet no existe."
    exit 1
fi

# Verifica los parámetros
case $1 in
    -dc|--docker)
        grep -i "docker" $cheatsheet
        ;;
    -pm|--pacman)
        grep -i "pacman" $cheatsheet
        ;;
    -ya|--yay)
        grep -i "yay" $cheatsheet
        ;;
    -tf|--terraform)
        grep -i "terraform" $cheatsheet
        ;;
    -py|--python)
        grep -i "py" $cheatsheet
        ;;
    -go|--golang)
        grep -i "go" $cheatsheet
        ;;
    -h|--help)
	cat $helper
	;;
    *)
        cat $cheatsheet
        ;;
esac
