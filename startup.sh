#!/bin/bash

export DISPLAY=:0.0
Xvfb -ac &> /dev/null &
sleep 2
x11vnc -nopw -noxrecord -noxfixes -noxdamage -forever -display :0 &> /dev/null &
fluxbox &> /dev/null &

# this makes sure that one can access root by simply exiting the shell launched into user
su user
cd
/bin/bash
