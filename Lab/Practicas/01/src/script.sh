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
#traceroute

# pendientes
#Nmap -O para sistema operativo, verificamos que es de oracle vm,
#      -sS
#      checar que es reverse dns

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

function get_traceroute() {
    echo -e "\t=====\n\tInfo de tracetoute \n\t====="

    cont=0
    for i in $(traceroute $1); do
	if [ "$cont" -eq "2" ]; then	    
	    gateway=$i
	fi
	echo -e "\t${i}"
	cont=$(( cont + 1 ))
    done
    echo -e "\n\tEl gateway de la red es: ${gateway:14:11}\n"
    echo -e "=====\n====="
}

function get_nmap() {

    cont=0
    for i in $(nmap $1); do
	if [ "$cont" -eq "2" ]; then
	    latencia=$i$
	    ## 3 para ips no checadas
	    ## 4 para reverse dns
	    ## 5 puertos no revisados
	    ## >= 6 puerto estado servicio
	fi
	cont=$(( cont + 1 ))
    done
    echo -e "\tlatencia: ${latencia:12:5}"
}

## start script
ping -c1 $1 > /dev/null
if [ ! $? -eq 0 ]; then
    echo "No se pudo conectar a $1"
else
    echo "=========="
    echo "Se establecio conexión con $1"
    echo "=========="

    get_nslookup "$1"
    get_traceroute "$1"
    get_nmap "$1"
    
fi
