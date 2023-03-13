#!/bin/bash
icon="$HOME/.config/i3/lock_icon_white.png"
darkicon="$HOME/.config/i3/lock_icon_dark.png"
tmpbg=$(mktemp /tmp/XXXXXXXXXXXXXXX.png)
import -window root $tmpbg

VALUE="60"
COLOR=$(convert "$tmpbg" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

if [ "$COLOR" -gt "$VALUE" ]; then
    icon="$darkicon"
    PARAM=(--layout-color=00000000 --inside-color=00000000 --ring-color=0000003e \
        --line-color=00000000 --keyhl-color=ffffff80 --ringver-color=ffffff00 \
        --separator-color=22222260 --insidever-color=ffffff1c \
        --ringwrong-color=ffffff55 --insidewrong-color=ffffff1c)
else
    icon="$lighticon"
    PARAM=(--layout-color=ffffff00 --inside-color=ffffff00 --ring-color=ffffff3e \
        --line-color=ffffff00 --keyhl-color=00000080 --ringver-color=00000000 \
        --separator-color=22222260 --insidever-color=0000001c \
        --ringwrong-color=00000055 --insidewrong-color=0000001c)
fi

convert "$tmpbg" -filter Gaussian -thumbnail 20% -sample 500% "$tmpbg" 
convert "$tmpbg" "$icon" -gravity center -composite "$tmpbg"

i3lock "${PARAM[@]}" -i "$tmpbg"

rm $tmpbg
