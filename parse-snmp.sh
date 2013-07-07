#!/bin/bash

if [ $# -ne 1]; then
    echo  "Usage: $0 <snmpwalk-output-file>"
    exit
fi

echo -e "\n[*] User List\n####################"
grep '77.1.2.25.1.1' $1 | cut -d" " -f4

echo -e "\n[*] Installed Software\n####################"
grep hrSwInstalledName $1 | cut -d" " -f4-20

echo -e "\n[*] Running Processes\n####################"
grep hrSWRunName $1 | cut -d" " -f4

echo -e "\n[*] TCP Connections\n####################"
grep tcpConnState $1 |grep listen |cut -d"." -f6 | sort -nu

echo -e "\nRunning Services\n####################"
grep '77.1.2.3.1.1' $1 | cut -d" " -f4-20