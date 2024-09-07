#!/usr/bin/env  bash


#install `wf-recorder` to use this script
#       https://github.com/ammen99/wf-recorder

#check if running wayland

if [[ "$XDG_SESSION_TYPE" != wayland ]]; then
    echo "You are not running wayland!!" && exit
fi
#list audio outputs with this
# ` pactl list sinks | awk '/Name:/ {print $2}' | awk 'NR==1' `
device=$(pactl get-default-sink)
dir="$HOME/Videos"
name="$(date +'%Y-%m-%d_%I-%M-%S').mp4"
save="$dir/$name"
encoded_name="$dir/encoded_$name"
#codec_param="-p "crf=23" -p "fpsmax=30" "
mic_default=$(pactl get-default-source)
monitor=$(pactl list sources | awk '/Name:/ {print $2}' | grep "$device")

#quick fix for audio capture
#set default source to monitor to capture desktop audio
pactl set-default-source "$monitor"

function show_help () {
    printf "%s\n" "Usage:"
    printf "%s\n" "-g | --geometry , record selected geometry"
    printf "%s\n" "-s | --screen, record fullscreen"
    printf "%s\n" "-h | --help, shows help"
}

#checks if wf-recorder is running
pgrep -x "wf-recorder" > /dev/null && killall -s SIGINT wf-recorder && notify-send -t 3000 "Recording stopped" && exit

#if [[ "$1" == "-g" ]] || [[ "$1" == "--geometry" ]]; then
#    wf-recorder -g "$(slurp)" -f $save --codec libx264rgb --device /dev/dri/renderD128 $codec_param --audio $device --force-yuv 
#elif [[ "$1" == "-s" ]] || [[ "$1" == "--screen" ]]; then
#    wf-recorder -f $save --codec libx264rgb --device /dev/dri/renderD128 $codec_param --audio $device --force-yuv 
#elif [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]; then
#    show_help
#else
#    exit
#fi
case "$1" in
    -h|--help )
      show_help
      ;;
    -s|--screen )
      shift
      notify-send -t 3000 "Recording started"
      wf-recorder -f "$save" --codec libx264rgb "$codec_param" --audio "$device" 
      ;;
    -g|--geometry )
      shift
      notify-send -t 3000 "Recording started"
      wf-recorder -g "$(slurp)" -f "$save" --codec libx264rgb "$codec_param" --audio "$device" 
      ;;
    *)
   echo "Incorrect input provided"
   show_help
esac

#revert source to default device after recording is done
#pactl set-default-source "$mic_default"

#Encoding
function encode() {
    sleep 3
    notify-send -t 3000 "Starting encode..." && \
    ffmpeg -i "$save" -c:v libx264 -x264opts colorprim=bt709:transfer=bt709:colormatrix=smpte170m -crf 20 -c:a copy "$encoded_name" && \
    sleep 3 && \
    notify-send -t 3000 "Video is now ready!"
    rm -f "$save"
    exit
}

[ -f "$save" ] && encode || exit

