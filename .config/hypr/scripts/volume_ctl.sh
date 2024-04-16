#!/usr/bin/env sh

function print_error
{
cat << "EOF"
    ./volumecontrol.sh -[device] <action>
    ...valid device are...
        i -- [i]nput decive
        o -- [o]utput device
    ...valid actions are...
        i -- <i>ncrease volume [+5]
        d -- <d>ecrease volume [-5]
        m -- <m>ute [x]
EOF
}

function send_notification
{
    mute=`pamixer --get-mute`
    if [ "$mute" == "false" ] ; then
        dunstify "Muted" -r 91190 -t 800
    else
        vol=`pamixer --get-volume`
        angle="$(( (($vol + 2 ) / 5) * 5 ))"
        bar=$(seq --separator="─" "$(((vol - 1) / 4))" | sed 's/[0-9]//g')
        space=$(seq --separator=" " "$(((100 - vol) / 4))" | sed 's/[0-9]//g')
        dunstify "$vol% [$bar$space]" -r 91190 -t 800
    fi
}

# set device source
while getopts io SetSrc
do
    case $SetSrc in
    i) nsink=$(pamixer --list-sources | grep "_input." | head -1 | awk -F '" "' '{print $NF}' | sed 's/"//')
        dvce="mic" ;;
    o) nsink=$(pamixer --get-default-sink | grep "_output." | awk -F '" "' '{print $NF}' | sed 's/"//')
        dvce="speaker" ;;
    esac
done

if [ $OPTIND -eq 1 ] ; then
    print_error
fi


# set device action

shift $((OPTIND -1))
step="${2:-5}"

case $1 in
    i) pamixer -i ${step}
        send_notification ;;
    d) pamixer -d ${step}
        send_notification ;;
    m) pamixer -t
        send_notification ;;
    *) print_error ;;
esac
