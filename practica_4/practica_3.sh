#!/bin/bash
#Autores: Hayk Kocharyan (757715) y Jose Felix Yagüe (755416)
#Practica 3 ADSIS

root=$(id -u)
if [ $root = "0" ]
then
	#sudo sh -c "echo \"$usrexec	ALL=(ALL:ALL) ALL\" >> /etc/sudoers"
	
	#comprobar si hay 2 parámetros
	echo $#
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
				if [[ ( $name != "" ) && ( $pass != "" ) && ( $longName != "" ) ]]
				then
					#compruebas que id sea > 1815 
					#0 si existe 1 sino
					#comprobar que no existe el nombre
					id -u $name >/dev/null 2>&1
					#echo &(id -u $name)
					if [ $? -ne 0 ]
					then
						useradd -U -m -K UID_MIN=1815 -k /etc/skel -c "$longName" "$name" 2>/dev/null 
						echo "$name:$pass" | chpasswd
						passwd -x 30 $name | 2>/dev/null
						usermod -U $name
						echo "$longName ha sido creado"
					else
						echo "El usuario $name ya existe"
					fi
				else 
					echo "Campo invalido"
				fi
			done < "$2"

		elif [ $1 = "-s" ]
		then 
			if [ ! -d "/extra/backup" ]
			then
				mkdir -p /extra/backup
			fi
			while read line
			do
				name=$(echo $line | cut -d ',' -f1)
				#compruebas que id sea > 1815
				#0 si existe 1 sino
				#comprobar que no existe id
				id -u $name >/dev/null 2>&1
				if [ $? -eq 0 ] 
				then
					#borro
					tar -czf /extra/backup/$name.tar /home/$name 2>/dev/null
					#devuelve 0 si es correcto
					if [ !$? ] 
					then
							userdel -r $name 2>/dev/null
					fi
				fi
			done < "$2"
		else 
			echo -e "Opcion invalida.\n"
		fi
	else
		echo -e " 3_Numero de parametros incorrectos. \n"
	fi
		
else
	echo -e "Este script necesita privilegios de administracion. \n"
	exit 1
fi
