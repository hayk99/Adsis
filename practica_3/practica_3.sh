#!/bin/bash
#Autores: Hayk Kocharyan (757715) y Jose Felix Yagüe (755416)
#Practica 3 ADSIS

root=$(sudo id -u)
if [ $root = "0" ]
then
	usrexec=$(whoami)
	sudo sh -c "echo \"$usrexec	ALL=(ALL:ALL) ALL\" >> /etc/sudoers"
	
	#comprobar si hay 2 parámetros
	if [ $# = 2 ]
	then
		#comprobar si es añadir o eliminar
		if [ $1 = "-a" ]
		then
			...
		elfi [ $1 = "-s" ]
		then 
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
