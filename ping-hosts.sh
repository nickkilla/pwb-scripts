#!/bin/bash
for ip in $(seq 200 250); do
    ping -c 1 192.168.11.$ip | grep "bytes from"  | cut -d" " -f4 | cut -d":" -f1 &
done
