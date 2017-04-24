#!/bin/bash

# Increase or decrease brightness

direction=$1
amount=$2
brightness=$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')
echo "Brightness before: " $brightness

if [[ -n "$direction" ]] && [[ -n "$amount" ]] && [[ -n "$brightness" ]]; then
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
    echo "Arguments are 'u n' or 'd n' where u or d = up or down and n is a value from 0.01 to 0.2. Depends on 'xrandr'."
fi





