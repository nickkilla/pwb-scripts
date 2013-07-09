#!/bin/bash
for name in $(cat dns.txt);do
    host $name.thinc.local | grep "has address" | cut -d" " -f1,4
done