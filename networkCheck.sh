#!/bin/bash

if [ -n "$1" ]
then
  echo 
  echo "welcome to networkCheck $USER"
  echo  
  while getopts :t opt
  do
    case "$opt" in 
      t) echo "local ip: $(hostname -I)"
        ipGateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
        echo
        if [ -n "$(ping $ipGateway -c 3 | grep 'time=' | awk '{print $7}')" ]
          then
            echo "your connection with the Gateway is fine"
          else
            echo "not local connection with the Gateway"
        fi;;
      *) echo "$opt is not an option";;
    esac
  done
else
  echo "TODO"
fi



exit

