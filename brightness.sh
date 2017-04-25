#!/bin/bash

# Increase or decrease brightness
function fnc_help {
    echo "Depends on 'xrandr'."
    echo ""
    echo "To set brightness:"
    echo "$ ./brightness.sh u n     # = brightness 'up' by n"
    echo "$ ./brightness.sh d n     # = brightness 'down' by n"
    echo "n is a value between 0.01 and 0.2."
    echo ""
    echo "To show brightness:"
    echo "$ ./brightness.sh s       # = 'show' brightness for active monitor"
    echo ""
}

direction=$1
amount=$2

if ! [[ -n "$direction" ]]; then
  fnc_help
  exit 1
fi

# brightness=$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')

# attempt to get active screen and brightness value
# haven't tested this on multiple screens. if it works at all, it will only dim one screen..
# access array items with: ${screen[n]}
screen=($(xrandr --verbose | awk '/ connected/{screen=$1}/Brightness/{brightness=$2}END{print (screen, brightness)}'))
echo "Connected monitor detected:" ${screen[0]}

if [[ "$direction" = 's' ]]; then
  echo "Brightness:" ${screen[1]}
  exit 0
fi

if [[ -n "$amount" ]] && [[ -n "$screen" ]]; then

  if (( $(echo "$amount > 0.2" | bc -l) )); then
    amount=0.2
  fi

  if (( $(echo "$amount < 0.01" | bc -l) )); then
    amount=0.01
  fi

  if [[ "$direction" = 'u' ]]; then
    echo 'Increase brightness'
    newbrightness=$(bc <<< ${screen[1]}+$amount)
    if (( $(echo "$newbrightness > 1.0" | bc -l) )); then
      echo "Brightness cannot exceed 1."
      newbrightness=1
    fi

  elif [[ "$direction" = 'd' ]]; then
    echo 'Decrease brightness'
    newbrightness=$(bc <<< ${screen[1]}-$amount)
    if (( $(echo "$newbrightness < 0.0" | bc -l) )); then
      echo "Brightness cannot be lower than 0."
      newbrightness=0
    fi
   fi

  xrandr --output ${screen[0]} --brightness $newbrightness
  echo "Brightness after: " $newbrightness

else
  fnc_help
  exit 1
fi





