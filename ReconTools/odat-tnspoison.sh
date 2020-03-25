#!/bin/bash

# Still in alfa. Need to install ldapsearch and test command.
# Need to revise this to allow for iteration through a list? 

if [ $# -eq 2 ]; then
    python3 odat.py tnspoison -s $1 -p $2 -d $3 --test-module
else
    echo "Illegal number of parameters"
    echo "USAGE: odat-tnspoison.sh <Target> <Port> <User List> <Password List>"
    exit 1
fi