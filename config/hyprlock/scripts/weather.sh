#!/bin/bash

# Cache directory for weather data
cache_dir="$HOME/.cache/eww/weather"
cache_weather_stat="${cache_dir}/weather-stat"
cache_weather_degree="${cache_dir}/weather-degree"
cache_weather_icon="${cache_dir}/weather-icon"

# Function to get weather data
get_weather_data() {
    # Your existing weather API code from the eww version
    KEY="4b94f4ff13e6b40065700b6409a9efb8"
    ID="4258510"
    UNIT="metric"
    
    weather=`curl -sf "http://api.openweathermap.org/data/2.5/weather?APPID=$KEY&id=$ID&units=$UNIT"`
    
    if [ ! -z "$weather" ]; then
        weather_temp=`echo "$weather" | jq ".main.temp" | cut -d "." -f 1`
        weather_icon_code=`echo "$weather" | jq -r ".weather[].icon" | head -1`
        weather_description=`echo "$weather" | jq -r ".weather[].description" | head -1 | sed -e "s/\b\(.\)/\u\1/g"`

        # Simplified icon mapping for hyprlock
        case "$weather_icon_code" in
            "01d") weather_icon=" " ;;
            "01n") weather_icon=" " ;;
            "02d"|"03d"|"04d") weather_icon=" " ;;
            "02n"|"03n"|"04n") weather_icon=" " ;;
            "09d"|"10d"|"09n"|"10n") weather_icon=" " ;;
            "11d"|"11n") weather_icon="" ;;
            "13d"|"13n") weather_icon=" " ;;
            "50d"|"50n") weather_icon=" " ;;
            *) weather_icon=" " ;;
        esac
        
        echo "$weather_icon" > "${cache_weather_icon}"
        echo "$weather_description" > "${cache_weather_stat}"
        echo "$weather_temp°C" > "${cache_weather_degree}"
    else
        echo "Weather Unavailable" > "${cache_weather_stat}"
        echo " " > "${cache_weather_icon}"
        echo "-" > "${cache_weather_degree}"
    fi
}

# Execute based on argument
if [[ "$1" == "--getdata" ]]; then
    get_weather_data
else
    # For hyprlock, display formatted weather info
    if [[ -f "$cache_weather_degree" && -f "$cache_weather_stat" && -f "$cache_weather_icon" ]]; then
        icon=$(cat "${cache_weather_icon}")
        degree=$(cat "${cache_weather_degree}")
        stat=$(cat "${cache_weather_stat}")
        echo "$icon $degree - $stat"
    else
        echo " Weather Unavailable"
    fi
fi
