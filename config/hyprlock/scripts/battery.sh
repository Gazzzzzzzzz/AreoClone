#!/bin/bash

# Try to find the correct battery path
battery_path=$(find /sys/class/power_supply -name "BAT*" | head -n 1)

if [ -z "$battery_path" ]; then
    # If no BAT* directory found, try other common battery paths
    battery_path=$(find /sys/class/power_supply -type d -name "*bat*" -o -name "*BAT*" | head -n 1)
fi

if [ -n "$battery_path" ]; then
    # Get the current battery percentage
    battery_percentage=$(cat "$battery_path/capacity" 2>/dev/null || echo "0")
    
    # Get the battery status (Charging or Discharging)
    battery_status=$(cat "$battery_path/status" 2>/dev/null || echo "Unknown")
else
    battery_percentage="0"
    battery_status="Unknown"
fi

# Define the battery icons using standard Nerd Font icons
battery_icons=("" "" "" "" "")  # 0-20%, 20-40%, 40-60%, 60-80%, 80-100%

# Define the charging icon
charging_icon=""

# Calculate the index for the icon array
icon_index=$((battery_percentage / 20))
if [ $icon_index -gt 4 ]; then
    icon_index=4
fi

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
    battery_icon="$charging_icon"
fi

# Output the battery percentage and icon
echo "$battery_percentage% $battery_icon"
