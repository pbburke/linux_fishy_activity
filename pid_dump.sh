#!/usr/bin/bash
# Pass in a PID, get out a bunch of details
# Incomplete, probably shouldn't be used in production. Just a brain worm dump
# 
# Author: Paul Burke 
#
set -euo pipefail
IFS=$'\n\t'

DIRECTORY=`dirname $0`
ARG=${1:-}

if [ $(id -u) = 0 ]; then 
    if [[ ! $ARG ]]
    then 
        echo "Usage: \"pid_dump.sh pid\""
        exit 1

    #todo: handle nonexistent PID here 
    #if
    #then

    else 
        ps $ARG
        echo ""
        echo "pid $ARG command name and cmdline"
        echo "###################################"
        ls -laR /proc/$ARG/comm
        ls -laR /proc/$ARG/cmdline
        
        echo ""
        echo "pid $ARG path"
        echo "###################################"
        ls -al /proc/$ARG/exe
        
        echo ""
        echo "pid $ARG working directory"
        echo "###################################"
        ls -laR /proc/$ARG/cwd

        echo ""
        echo "pid $ARG environment vars"
        echo "###################################"
        strings /proc/$ARG/environ

        #todo: add more, like a prompt to attempt making a backup of the process if exe is "(deleted)"

    fi
else
    echo "You should probably run this as root"
    exit 1
fi

