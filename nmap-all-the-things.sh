#!/bin/bash 

for ip in $(cat ~/scratch/up.txt); do
    echo "running nmap on " $ip
    nmap -oA $ip -sS -A -p1-65534 $ip &
done