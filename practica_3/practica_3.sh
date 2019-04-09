#!/bin/bash
#Autores: Hayk Kocharyan (757715) y Jose Felix Yagüe (755416)
#Practica 3 ADSIS

root=$(sudo id -u)
if [ $root = "0" ]
then
	usrexec=$(whoami)
	#sudo sh -c "echo \"$usrexec	ALL=(ALL:ALL) ALL\" >> /etc/sudoers"
	
	#comprobar si hay 2 parámetros
	if [ $# = 2 ]
	then
		filename=$1
		#comprobar si es añadir o eliminar
		if [ $1 = "-a" ]
		then
			while read line
			do
				id=$(echo $line| cut -d ',' -f1)
				pass=$(echo $line| cut -d ',' -f2)
				name=$(echo $line| cut -d ',' -f3)
			if [ $id -gt 1815 ]
				then 
					sudo useradd -u $id -g $i d-f 30 -p $pass $name
			done < "$1"

		elif [ $1 = "-s" ]
		then 
			sudo mkdir -p /extra/backup
			
			...
		else
			echo -e "Opcion invalida.\n"
		fi
	
	else
		echo -e "Numero de parametros incorrectos. \n"
	fi
		
else
	echo -e "Este script necesita privilegios de administracion. \n"
	exit 1
fi
