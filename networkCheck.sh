#!/bin/bash

if [ -n "$1" ]
then
  while getopts :t opt
  do
    case "$opt" in 
      t) echo "local ip: $(hostname -I)"
        ipGateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
        ping $ipGateway -c 3;;
      *) echo "$opt is not an option";;
    esac
  done
else
  echo "TODO"
fi



exit

