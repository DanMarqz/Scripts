#!/bin/bash

#Definir el color rosado y reiniciar el color al final
ROSADO="\033[35m"
CYAN="\033[36m"

hostname=$(uname -n)
prompt_system="${ROSADO} >_ @$hostname... ~:${CYAN}"

echo -e "$prompt_system ESTE ES EL USO ACTUAL DE LA MEMORIA... "
eval "sudo free -h"

# Pregunta de confirmación
read -p "$(echo -e "$prompt_system Desea continuar con el proceso de liberar espacio en la cache? (Y/n): ")" respuesta

# Convertir la respuesta a minúsculas y establecer por defecto 'Y'
respuesta=${respuesta,,} # Convierte a minúsculas
respuesta=${respuesta:-y} # Si está vacío, asume 'y'

if [[ "$respuesta" != "y"  ]]; then
    echo -e "$prompt_system Proceso cancelado por el usuario."
    exit 0
fi

echo -e "$prompt_system SE PROCEDE A LIBERAR EL ESPACIO EN MEMORIA DE buff/cache"
echo " "

echo -e "$prompt_system sysctl vm.drop_caches = 3 ~~~~ "
eval "sudo sysctl vm.drop_caches=3 | ~/progressline"
echo " "

echo -e "$prompt_system systemctl restart systemd-resolved ~~~~ "
eval "sudo systemctl restart systemd-resolved | ~/progressline"
echo " "

echo -e "$prompt_system pacman -Sc --noconfirm ~~~~ "
eval "sudo pacman -Sc --noconfirm | ~/progressline"
echo " "

echo -e "$prompt_system journalctl --vacuum-time = 2weeks ~~~~ "
eval "sudo journalctl --vacuum-time=2weeks | ~/progressline"
echo " "

echo -e "$prompt_system rm -rf ~/.cache/* ~~~~ "
eval "rm -rf ~/.cache/* | ~/progressline"
echo " "

echo -e "$prompt_system SE HA LIBERADO EL ESPACIO EN MEMORIA, ESTE ES EL USO ACTUAL DE LA MEMORIA..."
eval "sudo free -h"
