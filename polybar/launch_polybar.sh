#!/bin/bash

# Function to launch Polybar for each monitor
launch_polybar() {
  if type "xrandr" > /dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload toph &
    done
  else
    polybar --reload toph &
  fi
}

# Check if Polybar is already running
if pgrep -x "polybar" > /dev/null; then
  echo "Polybar is already running."
  exit 0
else
  echo "Starting Polybar..."
  launch_polybar
fi
