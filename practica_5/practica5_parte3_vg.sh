#!/bin/bash
#AUTORES: Hayk Kocharyan (757715) & Jose Felix Yagüe (755416)

if [ $# -ne 1 ]
then 
	#cogemos parametro del grupo
	vg="$1"
	#escaneamos para ver que grupos tenemos
	grupos=$(sudo vgscan)
	#miramos si existe el grupo deseado en los escaneados anteriormente
	echo "$grupos" | grep "$vg"
	if [ $existe ]
	then  
		echo "No existe grupo"$vg""
		exit 1
	else
		for parametro in "$@"; do
			sudo pvcreate "$parametro"
			sudo vgextend "$vg" "$parametro"
		done
	fi
else 
	exit 1
fi
	