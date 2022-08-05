#!/usr/bin/bash
# I will populate this with different tricks and ideas I find to hunt for fishy activity on Linux systems
# Incomplete, probably shouldn't be used in production. Just a brain worm dump
# 
# Author: Paul Burke 
#
set -euo pipefail
IFS=$'\n\t'

if [ $(id -u) = 0 ]; then 
    echo ""
    echo $(date +"%Y%m%d-%H%M%S")
    echo ""
    
    #separator for error log
    echo "########################################">> errlog
    echo "run " $(date +"%Y%m%d-%H%M%S") >> errlog
    echo "########################################">> errlog
    
    #look for processes running with a deleted binary, excluding what I think is firefox having recently been updated
    echo "########################################"
    echo "#Looking for deleted processes         #"
    echo "########################################"
    ls -la /proc/* 2>>errlog | grep \(deleted\) | grep -v \/usr\/lib64\/firefox\/firefox

    #todo: a lot more

    exit 0
else
    echo "You should probably run this as root"
    exit 1
fi

