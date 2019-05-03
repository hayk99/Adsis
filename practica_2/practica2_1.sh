#!/bin/bash
# Autores:  Hayk Kocharyan (757715) & Jose Felix Yagüe Royo (755416)
# Last update: 6/3/19


echo -n "Introduzca el nombre del archivo: "
read ruta 
if [ -f "$ruta" ]
then
	permisos=$(ls -l "$ruta" | cut -b 2,3,4)
	echo Los permisos del archivo $ruta son : $permisos
else 
	echo "$ruta no existe"
fi
