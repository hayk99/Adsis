#!/bin/bash
#AUTORES: Hayk Kocharyan (757715) & Jose Felix Yagüe (755416)

read grupo vol tam filsis dir basura
while [ $(echo "$grupo" | wc -w)  -gt 0  ]; do
	#escaneamos para ver que grupos tenemos
	grupos=$(sudo vgscan)
	#miramos si existe el grupo deseado en los escaneados anteriormente
	echo "$grupos" | grep "$grupo"
	if [ $? -gt 0 ]
	then  
		echo "No existe grupo"$grupo""
		exit 1
	fi
	#escaneamo para ver que volumenes hay
	logicos=$(sudo lvscan)
	#miramos si existe el nuestro
	echo "$logicos" | grep "$vol"
	if [ $? -gt 0 ]
	then
		echo creo
		#no existe, lo creo
		sudo lvcreate -L $tam --name $vol $grupo
		sudo mkfs -t $filsis /dev/$grupo/$vol
		sudo mount -t $filsis /dev/$grupo/$vol $dir
		uuid=$(sudo blkid -o value -s UUID /dev/$grupo/$vol)
		echo "UUID=$uuid $dir $filsis default 0 2" | sudo tee -a /etc/fstab
	else
		echo aumento
		#existe, aumento
		sudo lvextend -L+$tam /dev/$grupo/$vol
		#sudo e2fsck -f /dev/$grupo/$vol
		sudo resize2fs /dev/$grupo/$vol
	fi
	read grupo vol tam filsis dir basura
done
