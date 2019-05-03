#!/bin/bash
#Autores: Hayk Kocharyan (757715) y Jose Felix Yagüe (755416)
#Practica 3 ADSIS

root=$(id -u)
if [ $root = "0" ]
then
	#comprobar si hay 3 parámetros
	if [ $# = 3 ]
	then
			#comprobar si es añadir o eliminar
			if [ $1 = "-a" ]
			then
				while read lineIP <&4; do
					echo "leido $lineIP"
					if [[ $lineIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
					then
						#ssh -i ~/.ssh/id_as_ed25519 as@"$lineIP" echo prueba
						#echo "saca esto $?"
						if ssh -i ~/.ssh/id_as_ed25519 as@"$lineIP" echo prueba 
						then
							while read line <&3;do
								echo "ip leida $lineIP"
								echo "linea leida $line"
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
									ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" "sudo id -u $name >/dev/null 2>&1"
									if [ $? -ne 0 ]
									then
										ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " sudo useradd -U -m -K UID_MIN=1815 -k /etc/skel -c "$longName" "$name" 2>/dev/null "
										ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " sudo echo "$name:$pass" | sudo chpasswd "
										ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " sudo passwd -x 30 $name | 2>/dev/null "
										ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " sudo usermod -U $name "
										echo "$longName ha sido creado"
									else
										echo "El usuario $name ya existe"
									fi
								else 
									echo "Campo invalido"
								fi
							done 3< "$2"
						fi
					else echo ip no valida 
					fi
				done 4< "$3"
			elif [ $1 = "-s" ]
			then 
				while read lineIP; do
					if [[ $lineIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
					then
						if  ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " test -d "/extra/backup" "
						then
							  ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " mkdir -p /extra/backup "
						fi
						while read line
						do
							name=$(echo $line | cut -d ',' -f1)
							#compruebas que id sea > 1815
							#0 si existe 1 sino
							#comprobar que no existe id
							  ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " id -u $name >/dev/null 2>&1 "
							if [ $? -eq 0 ] 
							then
								#borro
								  ssh -T -i ~/.ssh/id_as_ed25519 as@"$lineIP" " tar -czf /extra/backup/$name.tar /home/$name 2>/dev/null "
								#devuelve 0 si es correcto
								if [ !$? ] 
								then
										 ssh  -i ~/.ssh/id_as_ed25519 as@"$lineIP" " userdel -r $name 2>/dev/null "
								fi
							fi
						done < "$2"
					else echo ip incorrecta
					fi
				done < "$3"
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
