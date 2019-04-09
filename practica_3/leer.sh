#!/bin/bash
while read line
do
	id=$(echo $line| cut -d ',' -f1)
	pass=$(echo $line| cut -d ',' -f2)
	name=$(echo $line| cut -d ',' -f3)
done < "$1"
