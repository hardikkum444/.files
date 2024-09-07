#!/bin/sh

if [[ $(xrdb -query) == "" ]]; then
    xrdb "$HOME/.Xdefaults"
fi

image(){

    path1="$HOME/Pictures/Wallpapers"
    choose=$(nsxiv -r -t -q -o "$path1")
    #[[ -d $HOME/Pictures/Wallpapers ]] || mkdir -p $Home/Pictures/Wallpapers/

    if [[ -z "$choose" ]]; then
        exit 0
    else
        ln -sf "$choose" "$path1"/wallpaper 
        pkill swaybg 
        swaybg -i "$path1"/wallpaper -m fill & 
    fi

}


video(){

    pidof "mpvpaper" && pkill mpvpaper > /dev/null
    path2="$HOME/Downloads/Vid_wallpapers"
    video=$(/usr/bin/ls "$path2" | shuf -n 1)
    mpvpaper -f -p -o "hwdec=auto panscan=1 no-audio loop" eDP-1 "$path2"/"$video" 1>/dev/null

}

[[ "$1" = "-v" ]] && video && exit 0
[[ "$1" = "-w" ]] && image && exit 0

