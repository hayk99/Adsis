
#BORRAR

iptables -F
iptables -t nat -F
iptables -t nat -Z
#borramos las iptables existentes y ponemos a 0 los contadores

#bloqueamos todo trafico al host o enrutado por host



# Permitimos todo tráfico intranet
#1
iptables -A FORWARD -i enp0s9 -j ACCEPT
#4
iptables -A FORWARD -i enp0s10 -j ACCEPT
#---------------------------------------------------------------------------------------

# intranet con acceso a internet
#2
iptables -t nat -A POSTROUTING -s 192.168.1.2/30 -o enp0s3 -j SNAT --to 192.168.56.2
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o enp0s3 -j MASQUERADE
#6
iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -o enp0s3 -j MASQUERADE
#---------------------------------------------------------------------------------------


# Intranet con acceso al host debian
#8
iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -d 192.168.56.0/24 -o enp0s8 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -d 192.168.56.0/24 -o enp0s8 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.3.0/24 -d 192.168.56.0/24 -o enp0s8 -j MASQUERADE
#---------------------------------------------------------------------------------------


# Extranet con acceso al servidor web de debian2 mediante http (80) o https (443)

#3
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 80 -j DNAT --to 192.168.1.2:80
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 443 -j DNAT --to 192.168.1.2:443

#---------------------------------------------------------------------------------------



# Habilitar acceso al servidor ssh debian5
#7
iptables -t nat -A PREROUTING -i enp0s3 -p tcp --dport 22 -j DNAT --to 192.168.3.2:22
iptables -t nat -A PREROUTING -i enp0s8 -p tcp --dport 22 -j DNAT --to 192.168.3.2:22

#---------------------------------------------------------------------------------------

# bucle local

iptables -A INPUT -i lo -d 127.0.0.1 -j ACCEPT
#---------------------------------------------------------------------------------------


# Extranet con permiso de respuesta a los pings

iptables -A INPUT -i enp0s3 -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT														
iptables -A INPUT -i enp0s8 -p icmp -m state --state ESTABLISHED,RELATED -j ACCEPT
# Denegar ping a debian1 desde extranet
iptables -A INPUT -i enp0s3 -p icmp -j DROP
iptables -A INPUT -i enp0s8 -p icmp -j DROP

iptables -A FORWARD 
#---------------------------------------------------------------------------------------


# Aceptamos el resto de pings

iptables -A INPUT -p icmp -j ACCEPT
#---------------------------------------------------------------------------------------

