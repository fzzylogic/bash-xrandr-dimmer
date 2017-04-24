This is a bash script to increase or decrease the brightness of ones screen using xrandr. 

Note: 'xrandr' changes brightness in software, not hardware.

Brightness is a value between 0 and 1. 0 means completely black.

# examples
$ ./brightness.sh u 0.2     # brightness 'up' by 0.2
$ ./brightness.sh d 0.2     # brightness 'down' by 0.2

Amount of brightness adjustment is constrained between 0.01 and 0.2.

License: MIT



