#!/usr/bin/env bash

#dependencies: `grim` `slurp` `swappy` `grimshot` `wl-clipboard` `jq` 

grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp    )" - | swappy -f -
