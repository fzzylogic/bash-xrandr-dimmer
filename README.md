This is a bash script to increase or decrease the brightness of ones screen using xrandr.

I made this because changing the backlight intensity on my laptop wasn't working under Lubuntu 17.04.

Note: 'xrandr' changes brightness in software, not hardware.

Brightness is a value between 0 and 1. 0 means completely black.

# Examples
    $ ./brightness.sh u 0.2     # brightness 'up' by 0.2
    $ ./brightness.sh d 0.2     # brightness 'down' by 0.2
    $ ./brightness.sh s         # output the current brightness

Amount of brightness adjustment is constrained between 0.01 and 0.2.

A convenient way to use this is to connect it to whatever hotkeys you use for brightness adjustment.

License: MIT
