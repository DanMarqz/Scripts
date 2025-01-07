#!/bin/bash

# Nombre del archivo
cheatsheet="$HOME/Documents/cheatsheet.md"
cheatsheet_ranger="$HOME/Documents/cheatsheet-ranger.md"
helper="$HOME/Documents/help.md"

# Verifica si el archivo existe
if [[ ! -f $cheatsheet ]]; then
    echo "El archivo $cheatsheet no existe."
    exit 1
fi

# Verifica los parámetros
case $1 in
    -d|--docker)
        grep -i "docker " $cheatsheet
        ;;
    -de|--deno)
        grep -i "deno " $cheatsheet
        ;;
    -db|--debian)
        grep -i "debian " $cheatsheet
        ;;
    -dc|--docker-compose)
        grep -i "docker-compose" $cheatsheet
        ;;
    -py|--python)
        grep -i "py" $cheatsheet
        ;;
    -go|--golang)
        grep -i "golang " $cheatsheet
        ;;
    -git|--gitzsh)
        grep -i "gitzsh" $cheatsheet
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
    -rg|--ranger)
        cat $cheatsheet_ranger
        ;;
    -h|--help)
	cat $helper
	;;
    *)
        cat $cheatsheet
        ;;
esac
