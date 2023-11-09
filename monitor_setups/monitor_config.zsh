#!/bin/zsh
##############################################
# Monitor config tool for zsh.
#   Author: Magnus Sörensen
##############################################

monitor_config(){
    # DISPLAY="$(xrandr --query | grep -oh -e '^DP-.* connected')"
    MONITORSETUP="$(xrandr --query )"
    DISPLAY="$(echo "$MONITORSETUP" | grep -oh -e '^DP-.* connected')"
    # echo "$DISPLAY test"
	MONITORS=()

    for disp in $DISPLAY; do
		name="$(echo $disp | grep -oh -e '^DP-[0-9]-[0-9]')"
		resulution="$(echo "$MONITORSETUP" | grep -A 1 -e "$disp" | grep -oh -P "^\s*\K[0-9]+x[0-9]+")"

    	declare -A monitor_d
		monitor_d["disp"]="$disp"
		monitor_d["name"]="$name"
		monitor_d["resulution"]="$resulution"

		MONITORS+=($monitor_d)
    done
	echo "$MONITORS"
	# echo "name: ${MONITORS[1]["disp"]}"
	for monitor in "${MONITORS[@]}"; do
		echo "$monitor["disp"]"
	done
}
monitor_config
