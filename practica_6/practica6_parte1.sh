#!/bin/bash
#AUTORES: Hayk Kocharyan (757715) & Jose Felix Yagüe (755416)

echo "USUARIOS Y CARGA MEDIA DE TRABAJO"
echo ----------------------------------------------------
echo Maquina Local:
uptime | sed -r 's/^[^,]*, *([0-9] *[a-z]+), *([a-z]+)/\1 --> \2/g' 
echo Maquina Remota
ssh as@192.168.56.3 uptime | sed -r 's/^[^,]*, *([0-9] *[a-z]+), *([a-z]+)/\1 --> \2/g' 
echo


echo "MEMORIA OCUPADA Y LIBRE"
echo ----------------------------------------------------
echo Maquina Local:
mem=$(free -h | sed -r -e 's/^( .*)//g' | grep "Mem" | sed -r -e 's/^[^ ]*//g' -e 's/[ ]+/ /g' -e 's/^ //')
total=$(echo $mem | cut -d' ' -f 1)
libre=$(echo $mem | cut -d' ' -f 2)
echo  El total es $total y disponemos de $libre
echo Maquina Remota:
mem=$(ssh as@192.168.56.3 free -h | sed -r -e 's/^( .*)//g' | grep "Mem" | sed -r -e 's/^[^ ]*//g' -e 's/[ ]+/ /g' -e 's/^ //')
total=$(echo $mem | cut -d' ' -f 1)
libre=$(echo $mem | cut -d' ' -f 2)
echo  El total es $total y disponemos de $libre
echo

echo "SWAP UTILIZADO"
echo ----------------------------------------------------
echo Maquina local
swap=$(free -h | sed -r -e 's/^( .*)//' | grep "Swap" | sed -r -e 's/^[^ ]*//g' -e 's/[ ]+/ /g' -e 's/^ //')
swapLibre=$(echo $swap | cut -d' ' -f 2)
echo Memoria swap utilizada: $swapLibre
echo Maquina remota
swap=$(ssh as@192.168.56.3 free -h | sed -r -e 's/^( .*)//' | grep "Swap" | sed -r -e 's/^[^ ]*//g' -e 's/[ ]+/ /g' -e 's/^ //')
swapLibre=$(echo $swap | cut -d' ' -f 2)
echo Memoria swap utilizada: $swapLibre
echo

echo "ESPACIO OCUPADO"
echo ----------------------------------------------------
echo Maquina Local:
echo -n "Espacio ocupado y libre: "
df -h --total |grep "total" | sed -r 's/[ ]+/ /g' | cut -d' ' -f 2,3
echo Maquina Remota:
echo -n "Espacio ocupado y libre: "
ssh as@192.168.56.3 df -h --total |grep "total" | sed -r 's/[ ]+/ /g' | cut -d' ' -f 2,3
echo

echo "NUMERO DE PUERTOS ESCUCHANDO"
echo ----------------------------------------------------
echo Maquina Local:
netstat -l | grep -c LISTENING
echo Maquina Remota:
ssh as@192.168.56.3 "netstat -l | grep -c LISTENING"
echo

echo "NUMERO DE CONEXIONES ESTABLECIDAS"
echo ----------------------------------------------------
echo Maquina Local:
netstat -l | grep -c CONNECTED
echo Maquina Remota:
ssh as@192.168.56.3 "netstat -l | grep -c CONNECTED"
echo

echo "NUMERO DE PROGRAMAS EN EJECUCIÓN"
echo ----------------------------------------------------
echo Maquina Local:
ps -A | wc -l
echo Maquina Remota:
ssh as@192.168.56.3 "ps -A | wc -l"
