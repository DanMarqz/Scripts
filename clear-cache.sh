#!/bin/bash
echo " ~~~~>_ ESTE ES EL USO ACTUAL DE LA MEMORIA... "
eval "sudo free -h"

echo " ~~~~>_ SE PROCEDE A LIBERAR EL ESPACIO EN MEMORIA DE buff/cache"
echo " "

echo " ~~~~ sysctl vm.drop_caches = 3 ~~~~ "
eval "sudo sysctl vm.drop_caches=3 | ~/progressline"
echo " "

echo " ~~~~ systemctl restart systemd-resolved ~~~~ "
eval "sudo systemctl restart systemd-resolved | ~/progressline"
echo " "

echo " ~~~~ pacman -Sc --noconfirm ~~~~ "
eval "sudo pacman -Sc --noconfirm | ~/progressline"
echo " "

echo "~~~~ journalctl --vacuum-time = 2weeks ~~~~ "
eval "sudo journalctl --vacuum-time=2weeks | ~/progressline"
echo " "

echo " ~~~~ rm -rf ~/.cache/* ~~~~ "
eval "rm -rf ~/.cache/* | ~/progressline"
echo " "

echo " ~~~~>_ SE HA LIBERADO EL ESPACIO EN MEMORIA, ESTE ES EL USO ACTUAL DE LA MEMORIA..."
eval "free -h"
