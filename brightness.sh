#!/bin/bash

# Increase or decrease brightness

direction=$1
amount=$2
brightness=$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')

if ! [[ -n "$direction" ]]; then
    exit 1
fi

if [[ "$direction" = 's' ]]; then
  echo "Current brightness is:" $brightness
  exit 0
fi

if [[ -n "$amount" ]] && [[ -n "$brightness" ]]; then

  if (( $(echo "$amount > 0.2" | bc -l) )); then
    amount=0.2
  fi

  if (( $(echo "$amount < 0.01" | bc -l) )); then
    amount=0.01
  fi

  if [[ "$direction" = 'u' ]]; then
    echo 'increase brightness'
    newbrightness=$(bc <<< $brightness+$amount)
    if (( $(echo "$newbrightness > 1.0" | bc -l) )); then
      newbrightness=1
    fi

  elif [[ "$direction" = 'd' ]]; then
    echo 'decrease brightness'
    newbrightness=$(bc <<< $brightness-$amount)
    if (( $(echo "$newbrightness < 0.0" | bc -l) )); then
      newbrightness=0
    fi
   fi

  xrandr --output LVDS-1 --brightness $newbrightness
  echo "Brightness after: " $newbrightness

else
    echo "Depends on 'xrandr'."
    echo ""
    echo "To set brightness:"
    echo "$ ./brightness.sh u n     # = brightness 'up' by n"
    echo "$ ./brightness.sh d n     # = brightness 'down' by n"
    echo "n is a value between 0.01 and 0.2."
    echo ""
    echo "$ ./brightness.sh s       # = 'show' brightness for active monitor"
fi





