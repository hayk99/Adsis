#!/bin/bash
# Autores:  Hayk Kocharyan (757715) & Jose Felix Yagüe Royo (755416)
# Last update: 10/3/19


echo -ne "Introduzca una tecla: \n"
##################################
#con esta opción lee solo una tecla de todas las que metas y acto seguido saca la salida
read -n1 tecla
##################################
#con esta opción lee todo y solo tiene en cuenta la primera tecla
#read tecla
#input="$(echo $tecla | cut -b 1)"

if [[ $tecla =~ ^[a-zA-Z]$ ]]
then
	echo -e "\n$tecla es una letra"
elif [[ $tecla =~ ^[0-9]+$ ]]
then
	echo -e "\n$tecla es un numero"
else
	echo -e "\n$tecla es un caracter especial"
fi