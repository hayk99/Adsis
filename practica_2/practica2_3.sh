#!/bin/bash
# Autores:  Hayk Kocharyan (757715) & Jose Felix Yagüe Royo (755416)
# Last update: 17/3/19
if [ $# = 1 ]
then 	if [ -f "$1" ]
	then 	chmod u+x $1
		chmod g+x $1
		stat -c "%A" $1
	else 	echo "$1 no existe"
	fi
else 	echo "Sintaxis: practica2_3.sh  <nombre_archivo>"
fi
