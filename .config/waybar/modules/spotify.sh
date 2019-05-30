#!/bin/sh

class=$(playerctl metadata --player=spotifyd --format '{{lc(status)}}')
icon=""

if [[ $class == "playing" ]] || [[ $class == "paused" ]]; then
  info=$(playerctl metadata --player=spotifyd --format '{{title}} - {{artist}} - {{album}}')
  if [[ ${#info} > 60 ]]; then
    info=$(echo $info | cut -c1-60)"..."
  fi
  text=$info" "$icon
elif [[ $class == "stopped" ]]; then
  text=""
else
  text=""
  class="stopped"
fi

echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"
