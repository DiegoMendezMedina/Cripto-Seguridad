#!/bin/bash

IFS=$'\n'

function get_whois() {
    cont=0
    for i in $(whois -H $1); do	
	if [ "${i:0:1}" != "%" ]; then	    
	    echo "$i"
	fi
	cont=$(( cont + 1 ))
    done
}

function get_nslookup() {
    cont=0
    for i in $(nslookup $1); do
	if [ "$cont" -eq "3" ]; then
	    echo "nombre: ${i:6}"		
	elif [[ "${i:0:7}" == "Address" && "$cont" -ge "2" ]]; then
	    echo "direcciòn: ${i:8}"	    
	fi
	cont=$(( cont + 1 ))
    done
}

function get_traceroute() {
    echo -e "\n\t=====\n\tSaltos para lograr la conexiòn \n\t====="

    for i in $(traceroute $1); do
	echo -e "\t${i}"
    done
    
    echo -e "\t=====\n\tFin de saltos\n\t====="
}

function get_nmap() {
    echo -e "\t==="
    cont=0
    for i in $(nmap $1); do
	if [ "$cont" -ge "2" ]; then
	    echo -e "\t$i"
	fi
	cont=$(( cont + 1 ))
    done
    echo -e "\t==="
}

## start script
ping -c1 $1 > /dev/null
if [ ! $? -eq 0 ]; then
    echo -e "error: no se pudo conectar a $1 con ping"
else
    echo "=========="
    echo "Se establecio conexión con $1 mediante ping"
    echo "=========="
fi
get_nslookup "$1"
get_traceroute "$1"
get_nmap "$1"
get_whois "$1"
