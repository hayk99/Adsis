#!/bin/bash
#AUTORES: Hayk Kocharyan (757715) & Jose Felix Yagüe (755416)

echo
echo -n "MAQUINA: "
ip addr show | grep 192 | sed -r 's/^[ ]+/ / g'
echo "USUARIOS Y CARGA MEDIA DE TRABAJO"
echo ----------------------------------------------------
uptime | sed -r 's/^[^,]*, *([0-9] *[a-z]+), *([a-z]+)/\1 --> \2/g' 


echo "MEMORIA OCUPADA Y LIBRE"
echo ----------------------------------------------------
mem=$(free -h | sed -r -e 's/^( .*)//g' | grep "Mem" | sed -r -e 's/^[^ ]*//g' -e 's/[ ]+/ /g' -e 's/^ //')
total=$(echo $mem | cut -d' ' -f 1)
libre=$(echo $mem | cut -d' ' -f 2)
echo  El total es $total y disponemos de $libre
echo

echo "SWAP UTILIZADO"
echo ----------------------------------------------------
swap=$(free -h | sed -r -e 's/^( .*)//' | grep "Swap" | sed -r -e 's/^[^ ]*//g' -e 's/[ ]+/ /g' -e 's/^ //')
swapLibre=$(echo $swap | cut -d' ' -f 2)
echo Memoria swap utilizada: $swapLibre
echo

echo "ESPACIO OCUPADO"
echo ----------------------------------------------------
echo -n "Espacio ocupado y libre: "
df -h --total |grep "total" | sed -r 's/[ ]+/ /g' | cut -d' ' -f 2,3
echo

echo "NUMERO DE PUERTOS ESCUCHANDO"
echo ----------------------------------------------------
netstat -l | grep -c LISTENING
echo

echo "NUMERO DE CONEXIONES ESTABLECIDAS"
echo ----------------------------------------------------
netstat -l | grep -c CONNECTED
echo

echo "NUMERO DE PROGRAMAS EN EJECUCIÓN"
echo ----------------------------------------------------
ps -A | wc -l
echo
