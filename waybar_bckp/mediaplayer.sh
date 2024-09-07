#!/bin/sh


pidof ncspot spotifyd spotify >/dev/null || exit
#pidof ncspot >/dev/null || exit
#player=spotify
[ -n "$(pgrep ncspot)" ] && player="ncspot"
[ -n "$(pgrep spotify)" ] && player="spotify"
[ -n "$(pgrep spotifyd)" ] && player="spotifyd"

[[ "$1" == "-p" ]] && playerctl -p $player play-pause

player_status=$(playerctl -p $player status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo "$(playerctl -p $player metadata artist) - $(playerctl -p $player metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl -p $player metadata artist) - $(playerctl -p $player metadata title)"
fi


