#!/usr/bin/env bash

# ================================================================================================================================
#
#                                                             STARTUP POLYBAR                                                          
#
#                                                           Update: 2023.01.16                                                      
#
# ================================================================================================================================

# TERMINATE ALREADY RUNNING BAR INSTANCES

killall -q polybar

# WAIT UNTIL THE PROCESSES HAVE BEEN SHUT DOWN

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [ -n $SECOND_MONITOR ]; then
    echo "LAUNCHING POLYBAR ON TWO SCREENS"

    # LAUNCH EXTERNAL SECOND SUCH THAT THE TRAY IS VISIBLE IN THIS MONITOR

    polybar external &
    sleep 0.2
    polybar laptop &
else
    echo "LAUNCHING POLYBAR ON A SINGLE SCREEN"
    polybar laptop &
fi

echo "POLYBAR LAUNCHED..."
