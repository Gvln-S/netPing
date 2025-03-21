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
  while [ -n "${local_ip:$count:1}" ]
  do 
    ((count++))
  done
  ((count = count * 2 + 8))
  echo $count
}

function local_connection {
  count=$(square_draw)
  divider=$(( (count-1)/2 ))

  for ((sup=0; sup<count; sup++))
  do
    echo -n "_"
  done
  echo

  for ((row=1; row<3; row++))
  do
    echo -n "|"
    for ((col=1; col<count-1; col++)); do
      if [ $col -eq $divider ]; then
        echo -n "|"
      else
        echo -n " "
      fi
    done
    echo "|"
  done

  for ((col=0; col<count; col++))
  do
    if [ $col -eq $divider ] || [ $col -eq 0 ] || [ $col -eq $((count - 1)) ]
    then
      echo -n "|"
    else
      echo -n "_"
    fi
  done
  echo
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
