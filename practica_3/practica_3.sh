#!/bin/bash
#Autores: Hayk Kocharyan (757715) y Jose Felix Yagüe (755416)
#Practica 3 ADSIS

root=$(id -u)
if [ $root = "0" ]
then
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
				#lee del fichero los campos
				name=$(echo $line | cut -d ',' -f1)
				pass=$(echo $line | cut -d ',' -f2)
				longName=$(echo $line | cut -d ',' -f3)
				#comprobamos que no sean campos vacios
				if [ $name != "" && $pass != "" && $longName != "" ]
				then
					#compruebas que id sea > 1815 
					#0 si existe 1 sino
					#comprobar que no existe el nombre
					id -u $name
					if [ $? ]
					then
						sudo useradd -U -m -K UID_MIN=1815 -c $longName $name
						echo "$name:$pass" | chpasswd
						sudo passwd $name -x 30
						echo "$longName ha sido creado"
					elif [ !$kk1 ]
					then 
						echo "El usuario $name ya existe"
					fi
				else 
					echo "Campo invalido"
				fi
			done < "$1"

		elif [ $1 = "-s" ]
		then 
			if [ ! -d "/extra/backup" ]
			then
				sudo mkdir -p /extra/backup
			fi
			while read line
			do
				name=$(echo $line | cut -d ',' -f1)
				#compruebas que id sea > 1815
				#0 si existe 1 sino
				#comprobar que no existe id
				id -u $name
				if [ !$? ]
				then
					#borro
					tar -cvzf /extra/backup/$name.tar.gz /home/$name
					userdel 
				elif [ $kk ]
				then
					echo "El usuario $ids no existe"
				fi

				#leemos solo el primer campo que es id
				ids=$(echo $line | cut -d ',' -f1)
				#comprobar que no existe usuario
				if [ ! $(id -u $id) ]
				then
					tar
					sudo userdel -r $name
				else
					echo "El usuario $ids ya existe"
				fi
			done < "$1"

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
