#!/bin/bash
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
    #todo: make errlog more useful
    echo "################################################">> errlog
    echo "run " $(date +"%Y%m%d-%H%M%S") >> errlog
    echo "################################################">> errlog
    
    #look for processes running with a deleted binary, excluding what I think is firefox having recently been updated
    echo "################################################"
    echo "#Looking for deleted processes                 #"
    echo "################################################"
    ls -laR /proc/* 2>>errlog | grep \(deleted\) | grep -v \/usr\/lib64\/firefox\/firefox

    echo "################################################"
    echo "#Looking for processes running from tmp or dev #"
    echo "################################################"
    ls -laR /proc/*/cwd 2>>errlog | grep tmp
    ls -laR /proc/*/cwd 2>>errlog | grep dev

    echo "################################################"
    echo "#Looking for history files linked to /dev/null #"
    echo "################################################"
    ls -laR / 2>>errlog | grep .*history |  grep null
    
    #todo: a lot more
    #like instead of doing a bunch of ls, make an array/db of sorts

    exit 0
else
    echo "You should probably run this as root"
    exit 1
fi

