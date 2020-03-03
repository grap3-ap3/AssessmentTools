#!/bin/bash

# sysinfo_page - A script to run sublist3r against primary domains.

if [ $# == 2 ]; then
    for domain in `cat $1`
        do
            echo "Now getting sublist3r record for: $host"
            `python /pentest/intelligence-gathering/sublist3r/sublist3r.py -d $host -o $2`
        done
else
    echo "Illegal number of parameters"
    echo "USAGE: sublist3r.sh <input file> <output file>"
    exit 1
fi
