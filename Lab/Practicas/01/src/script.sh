#!/bin/bash

## Dominios
# unam.mx
# pemex.com
# gob.mx
# ipn.mx
# ips

## Comandos:
# implementados
# Ping
# nslookup

# pendientes
#traceroute
#Nmap
#whois
#sublist3r
#subfinder
#findomain
#dnsmap
#dnsrecon
#EtherApe

IFS=$'\n'


function get_nslookup() {
    cont=0
    for i in $(nslookup $1); do
	if [ "$cont" -eq "3" ]; then
	    echo "nombre: "${i:6}		
	elif [ "$cont" -eq "4" ]; then
	    echo "ipv4: "${i:9}
	elif [ "$cont" -eq "6" ]; then
	    echo "ipv6: "${i:9}
	fi
	cont=$(( cont + 1 ))
    done
}

ping -c1 $1 > /dev/null
if [ ! $? -eq 0 ]; then
    echo "No se pudo conectar a $1"
else
    echo "=========="
    echo "Se establecio conexión con $1"
    echo "=========="

    get_nslookup "$1"
    
fi
