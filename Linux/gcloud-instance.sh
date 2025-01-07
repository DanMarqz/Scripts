#!/bin/bash

#Definir el color rosado y reiniciar el color al final
ROSADO="\033[35m"
CYAN="\033[36m"

hostname=$(uname -n)
prompt_system="${ROSADO} >_ @$hostname... ~:${CYAN}"

echo -e "$prompt_system Mostrando las instancias en gcloud... "
eval "gcloud compute instances list"

echo ""

# Solicitar los inputs al usuario
read -p "$(echo -e "$prompt_system  Por favor, indique el nombre de la instancia a operar ")" instance_name
read -p "$(echo -e "$prompt_system  Por favor, indique lo que desea hacer: Apagar (a) o Encender (e) ")" respuesta

respuesta=${respuesta,,}
respuesta=${respuesta:-n} # Si está vacío, asume 'n'

if [[ "$respuesta" == "n"  ]]; then
    echo -e "$prompt_system Proceso cancelado."
    exit 0
fi

if [[ "$respuesta" == "a"  ]]; then
    echo -e "$prompt_system Se procede a apagar la instancia..."
    eval "gcloud compute instances stop $instance_name --zone=us-central1-a"
    exit 0
fi

if [[ "$respuesta" == "e"  ]]; then
    echo -e "$prompt_system Se procede a encender la instancia..."
    eval "gcloud compute instances start $instance_name --zone=us-central1-a"
    exit 0
fi

