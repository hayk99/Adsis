#!/bin/bash

re='^[0-9]+$'
id -u user4
					#echo &(id -u $name)
					#if [[ ( $( id -u user4 ) = 0 ) || !( $( id -u user4 ) !=  $re ) ]]
					if [ $? -ne 0 ]
					then
						echo $?
						echo "$longName ha sido creado"
					else
						echo  $( id -u user1)
						echo "El usuario $name ya existe"
					fi