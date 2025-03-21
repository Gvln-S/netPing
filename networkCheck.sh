#!/bin/bash

function square_draw {
  local_ip=$(hostname -I)
  local count_ip=0
  local text="$1"
  local variable="$2"
  local con_sup="$3"

  while [ -n "${local_ip:$count_ip:1}" ]
  do 
    ((count_ip++))
  done

  ((count_ip = count_ip * 2 + 12))
  divider=$(( (count_ip-1)/2 ))

  for ((sup=0; sup<count_ip; sup++))
  do
    if [ $con_sup -lt 1 ] 
    then
      if [ $sup -eq 0 ] || [ $sup -eq $((count_ip - 1)) ]
      then
        echo -n " "
      else
        echo -n "_"
      fi
    fi
  done
  echo
  for ((row=1; row<3; row++))
  do
    echo -n "|"
    for ((col=1; col<count_ip-1; col++))
    do
      local count_text=0
      while [ -n "${text:$count_text:1}" ]
      do 
        ((count_text++))
      done
      local count_variable=0
      while [ -n "${variable:$count_variable:1}" ]
      do 
        ((count_variable++))
      done
      if [ $col -eq 2 ] && [ $row -eq 2 ]
      then
        echo -n "$text"
        col=$[$col + $count_text]
      fi
      if [ $col -eq $((divider + 2)) ] && [ $row -eq 2 ]
      then
        echo -n "$variable"
        col=$[$col + $count_variable]
      fi
      if [ $col -eq $divider ]
      then
        echo -n "|"
      else
        echo -n " "
      fi
    done
    echo "|"
  done
  for ((col=0; col<count_ip; col++))
  do
    if [ $col -eq $divider ] || [ $col -eq 0 ] || [ $col -eq $((count_ip - 1)) ]
    then
      echo -n "|"
    else
      echo -n "_"
    fi
  done
}

function gateway_connection {
  ip_gateway=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
  if [ -n "$(ping $ip_gateway -c 3 | grep 'time=' | awk '{print $7}')" ]
  then
    echo "your connection with the Gateway is fine"
  else
    echo "not local connection with the Gateway"
  fi
}

function local_connection {
  square_draw "local ip:" "$(hostname -I)" "0"
  square_draw "gateway ip:" "$(route -n | grep 'UG[ \t]' | awk '{print $2}')" "1"
  square_draw "dns ip:" "$((nmcli dev list || nmcli dev show ) 2>/dev/null | grep DNS | awk '{print $2}')" "1"
  square_draw "dchp ip:" "$(cat /etc/resolv.conf | grep "nameserver" | awk '{print $2}')" "1"
  square_draw "public ip:" "$(curl -s ifconfig.me)" "1"
  
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
