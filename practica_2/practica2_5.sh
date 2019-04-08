#!/bin/bash
# Autores:  Hayk Kocharyan (757715) & Jose Felix Yagüe Royo (755416)
# Last update: 10/3/19

echo -n "Introduzca el nombre de un directorio: "
read dir
#newDir=$(())
#echo newdir es: $newDir \n
 
if [ -d "$dir" ]
then 
	#files=$(ls -l "$dir" | egrep -c '^-')
	tot=$(ls -l "$dir" | wc -l)
	((tot--))
 	dirs=$(ls -l "$dir" | egrep -c '^d')
	let files=tot-dirs 
	echo "El numero de ficheros y directorios en $dir es de $files y $dirs, respectivamente"
else
	echo "$dir no es un directorio"
fi