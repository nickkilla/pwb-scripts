#!/bin/bash

echo "Please enter a class C IP network range"
echo "eg: 192.168.1"

read range

for ip in `seq 1 254`;do
    host $range.$ip | grep "name pointer" | cut -d" " -f5
done