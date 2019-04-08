#!/bin/bash
# Autores:  Hayk Kocharyan (757715) & Jose Felix Yagüe Royo (755416)
# Last update: 20/3/19
dir=$(ls -l ~ | egrep -c -E '^d.*bin[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]$')
files=$(ls -l | egrep -c '^-.*x')

if [ $dir = 0 ]
then
#no existe
	dtemp=$(mktemp -d binXXX -p ~)
	#dtemp=$(ls ~ | grep '^bin[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]$')
else
#existe
	bin=$(ls -tp ~ | egrep 'bin[a-zA-Z0-9][a-zA-Z0-9][a-zA-Z0-9]/$' | tail -1)
	echo $bin
	home="/home/"
	usr=$(whoami)
	barra="/"
	dtemp="$home$usr$barra$bin"
	#dtemp=~/$bin
	echo $dtemp
fi 
echo el directorio es $dtemp 
lista=$(ls -p |grep -v /)
cont=0
for var in $lista
do
	if test -x $var
	then 
		cp $var $dtemp
		echo $var ha sido copiado a $dtemp
		((cont++))

	fi
done
if [ $cont = 0 ]
then 
	echo No se ha copiado ningun archivos
else 
	echo Se han copiado $cont archivos
fi