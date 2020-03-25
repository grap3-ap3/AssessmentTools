#!/bin/bash

# Still in alfa. Need to install ldapsearch and test command.
# Need to revise this to allow for iteration through a list? 

if [ $# -eq 1 ]; then
	enum4linux -a -v -M -l -d $1 2>&1 | tee "enum4linux_$1.txt"
else
    echo "Illegal number of parameters"
    echo "USAGE: scan-enum4linux.sh <Target>"
    exit 1
fi