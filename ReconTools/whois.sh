#!/bin/bash

# sysinfo_page - A script to query WHOIS for pre-engagement staging.

if [ $# == 2 ]; then
    for host in `cat $1`
        do
            echo "Now getting WHOIS record for: $host"
            OrgName=`whois $host | grep "OrgName" | awk -F " " '{print $2}'`
            echo "$host : $OrgName" >> $2
        done
else
    echo "Illegal number of parameters"
    echo "USAGE: whois.sh <input file> <output file>"
    exit 1
fi
