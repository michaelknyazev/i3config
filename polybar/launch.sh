#!/usr/bin/env bash
dir="$HOME/.config/i3/polybar"

launch_bar() {
	killall -q polybar
	polybar -q main -c "$dir/bradius/config.ini" & 
	polybar -q tray -c "$dir/bradius/config.ini" &
}

launch_bar
