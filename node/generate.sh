#!/bin/bash
#sets up a virtual screen on unix machines

sudo Xvfb :1 -screen 0 1024x768x24 &
export DISPLAY=":1"
xinit ./app/Ossacip
