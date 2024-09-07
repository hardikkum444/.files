#!/usr/bin/env bash
#
#
bat_state=$(cat /sys/class/power_supply/BAT0/status)
cur_level=$(cat /sys/class/power_supply/BAT0/capacity)

if [[ "$bat_state" == "Discharging" ]] && [[ "$cur_level" < 20 ]]; then
    notify-send -u critical "Battery" "Connect charger now!!"
    exit 0
fi

