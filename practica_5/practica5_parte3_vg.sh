#!/bin/bash
#AUTORES: Hayk Kocharyan (757715) & Jose Felix Yagüe (755416)

if [ $# -ne 1 ]
then 
	#mostramos los atributos de los volumenes fisico actuales
	sudo pvdisplay
	#cogemos parametro del grupo
	vg="$1"
	#escaneamos para ver que grupos tenemos
	grupos=$(sudo vgscan)
	#miramos si existe el grupo deseado en los escaneados anteriormente
	echo "$grupos" | grep "$vg"
	if [ $? -eq 1]
	then  
		echo "No existe grupo "$vg""
		exit 1
	else
		for parametro in "$@"; do
			#creamos 
			sudo pvcreate "$parametro"
			#extendemos 
			sudo vgextend "$vg" "$parametro"
		done
	fi
	#mostramos los atributos de los volumenes fisico tras el script
	sudo pvdisplay
else 
	exit 1
fi
	
#vgreduce grupo /particion
#pvremove /particion