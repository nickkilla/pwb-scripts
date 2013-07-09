#!/bin/bash
#simple zone transfer script
# $1 is the first argument given after the bash script

#check for arg and print usage if none
if [ -z "$1" ]; then
    echo "[*] Simple Zone Transfer Script"
    echo "[*] Usage : $0 <domain name> "
    echo "[*] Example: $0 aeoi.org.ir "
    exit 0
fi

#if arg given, identify the dns servers for the domain
for server in $(host -t ns $1 | cut -d" " -f4); do
    #attempt axfr for each host
    host -l $1 $server | grep "has address"
done