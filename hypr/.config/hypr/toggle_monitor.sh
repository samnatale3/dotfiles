#!/bin/bash

# Get the monitor's disabled status
monitor_status=$(hyprctl monitors all | grep -A 15 "Monitor eDP-1" | grep "disabled" | awk '{print $2}')

# Check if the monitor is currently disabled
if [[ $monitor_status == "false" ]]; then
    # If the monitor is enabled, disable it
    hyprctl keyword monitor "eDP-1, disable"
else
    # If the monitor is disabled, enable it
    hyprctl keyword monitor "eDP-1, enable"
fi

