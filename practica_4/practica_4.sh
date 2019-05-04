#!/bin/bash
#Autores: Hayk Kocharyan (757715) y Jose Felix Yagüe (755416)
#Practica 4 ADSIS

root=$(id -u)
if [ $root = "0" ]
then
	#comprobar si hay 3 parámetros
	if [ $# = 3 ]
	then
			#comprobar si es añadir o eliminar
			if [ $1 = "-a" ]
			then
				#itero fichero de ips
				while read lineIP <&3; do
					#compruebo que sea un ip válida sintácticamente
					if [[ $lineIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
					then
						#hago ssh para ver si puedo realizar una conexion válida
						if ssh -i ~/.ssh/id_as_ed25519 as@$lineIP echo  >/dev/null 2>&1 
						then
							#itero fichero de usuarios a crear
							while read line <&4;do
								#lee del fichero los campos nombre, password, y nombre completo
								name=$(echo $line | cut -d ',' -f1)
								pass=$(echo $line | cut -d ',' -f2)
								longName=$(echo $line | cut -d ',' -f3)
								#comprobamos que no sean campos vacios
								if [[ ( $name != "" ) && ( $pass != "" ) && ( $longName != "" ) ]]
								then
									#comprobar que no existe el nombre del usuario que quiero añadir
									ssh -i ~/.ssh/id_as_ed25519 as@$lineIP "sudo id -u $name >/dev/null 2>&1"
									if [ $? -ne 0 ]
									then
										#añado suaurio
										ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo useradd -U -m -K UID_MIN=1815 -k /etc/skel -c "$longName" "$name" 2>/dev/null "
										#ponemos password deseado 
										ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo echo "$name:$pass" | sudo chpasswd "
										#añadimos fecha de expiracion del password
										ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo passwd -x 30 $name | 2>/dev/null "
										ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo usermod -U $name "
										echo $longName ha sido creado
									else
										echo El usuario $name ya existe
									fi
								else 
									echo "Campo invalido"
								fi
							done 4< "$2"
						else echo $lineIP no es accesible
						fi
					else echo formato ip: $lineIP no valido
					fi
				done 3< "$3"
			elif [ $1 = "-s" ]
			then 
				#itero fichero de ips
				while read lineIP <&3; do
					#compruebo que sea un ip válida sintácticamente
					if [[ $lineIP =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]
					then
						#hago ssh para ver si puedo realizar una conexion válida
						if ssh -i ~/.ssh/id_as_ed25519 as@$lineIP echo prueba 2>> /dev/null 
						then
							# compruebo que tenga el directorio /extra/backup
							if  ! ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " test -d /extra/backup "
							then
								#como no lo tengo, lo creo
								ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo mkdir -p /extra/backup "
							fi
							#itero fichero de usuarios
							while read line <&4 ; do
								#cojo solo el nombre, lo demás no me interesa
								name=$(echo $line | cut -d ',' -f1)
								#comprobar que existe usuario que me dispongo a borrar
								ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo id -u $name >/dev/null 2>&1 "
								if [ $? -eq 0 ] 
								then
									#hago la copia de sus archivos
									ssh -i ~/.ssh/id_as_ed25519 as@$lineIP " sudo tar -czf /extra/backup/$name.tar /home/$name 2>/dev/null "
									#devuelve 0 si es correcto
									if [ !$? ] 
									then
										#borro usuario si he podido crear la copia
										ssh -i ~/.ssh/id_as_ed25519  -i ~/.ssh/id_as_ed25519 as@"$lineIP" " sudo userdel -r $name 2>/dev/null "
									fi
								fi
							done 4< "$2"
						else echo $lineIP no es accesible
						fi 
					else echo formato ip: $lineIP incorrecta
					fi
				done 3< "$3"
			else 
				echo -e "Opcion invalida"
			fi
	else
		echo -e "Numero de parametros incorrectos"
	fi
		
else
	echo -e "Este script necesita privilegios de administracion"
	exit 1
fi
