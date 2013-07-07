#!/bin/bash

for snmpHost in $(cat ~/evidence/open-snmp-hosts.txt); do
    echo "users on " $snmpHost
    snmpwalk -c public -v1 $snmpHost 1.3 | grep 77.1.2.25 | cut -d" " -f4
done

