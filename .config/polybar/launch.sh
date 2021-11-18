#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if [ -n $SECOND_MONITOR ]; then
	echo "launching polybar on two screens"
	# launch external second such that the tray is visible in this monitor
	polybar external &
	sleep 0.2
	polybar laptop &
else
	echo "launching polybar on a single screen"
	polybar laptop &
fi

echo "Polybar launched..."
