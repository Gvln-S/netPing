#!/bin/bash

function gateway_connection {
  ip_gateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
  if [ -n "$(ping $ip_gateway -c 3 | grep 'time=' | awk '{print $7}')" ]
  then
    echo "your connection with the Gateway is fine"
  else
    echo "not local connection with the Gateway"
  fi
}

function square_draw {
  local_ip=$(hostname -I)
  local count=0
  while [ -n ${local_ip:$count:$[count + 1]} ]
  do 
    echo "${local_ip:$count:$[count + 1]}"
    count=$[count + 1]
  done
}

function local_connection {
  echo "
 _________________________________
|               |                 |
| local ip:     | $(hostname -I)  
|_______________|_________________|"
  square_draw
}

if [ -n "$1" ]
then
  echo 
  echo "welcome to networkCheck $USER"
  while getopts :t opt
  do
    case "$opt" in 
      t) local_connection;;
      *) echo "$opt is not an option";;
    esac
  done
else
  echo "TODO"
fi

exit
