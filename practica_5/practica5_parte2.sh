#!/bin/bash
#AUTORES: Hayk Kocharyan (757715) & Jose Felix Yagüe (755416)

if [ $# = 1 ]
then
	echo _____________________________________________________
	echo DISCOS DUROS DISPONIBLES Y TAMAÑO DE BLOQUE
	echo _____________________________________________________
	ssh -i ~/.ssh/id_as_ed25519 as@$1 "sudo sfdisk -s | egrep -v "^total""
	echo _____________________________________________________
	echo PARTICIONES Y TAMAÑOS
	echo _____________________________________________________
	ssh -i ~/.ssh/id_as_ed25519 as@$1 "sudo sfdisk -l | egrep -e "^disk" -e "\/d" -e "^device" "
	echo _____________________________________________________
	echo INFORMACION DE MONTAJE
	echo _____________________________________________________
	# con egrpe -v elegimos todas las lineas menos las que comienzan con 'tmpfs'
	ssh -i ~/.ssh/id_as_ed25519 as@$1 "sudo df -hT | egrep -v "^tmpfs""
else
	echo "incorrecta ejecucción"
	exit 1
fi