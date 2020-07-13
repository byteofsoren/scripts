SELECT=""
MODE=""
GOTO_END=0

function select_port() {
    ports="HDMI\nVGA\nexit"
    selected=$(echo -e "$ports" | dmenu)
    if [[ $selected == 'exit' ]]; then
        GOTO_END=1
        echo "EXIT"
    elif [[ $selected == "HDMI" ]]; then
        SELECT="HDMI2"
    elif [[ $selected == "VGA" ]]; then
        SELECT="DP1"
    fi
}

function select_mode() {
    modes="clone\nextend\noff\nexit"
    if [[ $GOTO_END == 0 ]]; then
        select_mode=$(echo -e "$modes" | dmenu)
        if [[ $select_mode == 'clone' ]]; then
            xrandr  --output $SELECT --auto
            GOTO_END=1
        elif [[ $select_mode == 'extend' ]]; then
            echo "Extend"
            select_extend
        elif [[ $select_mode == 'off' ]]; then
            #xrandr  --output $SELECT --off
            #xrandr  --output DP1 --off --output eDP1 --mode 1920x1080
            xrandr  --output $SELECT --off
        elif [[ $select_mode == 'exit' ]]; then
            GOTO_END=1
        fi
    fi
}

function select_extend() {
    directions="left\nright\ntob\nbot"
    dir=$(echo -e "$directions" | dmenu)
    if [[ $dir == 'left' ]]; then
        xrandr  --output $SELECT --auto --left-of eDP1
    elif [[ $dir == 'right' ]]; then
        xrandr  --output $SELECT --auto --right-of eDP1
    else
        echo "not implemented"
    fi
}

select_port
select_mode
