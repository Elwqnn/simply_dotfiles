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

shift $((OPTIND -1))
step="${2:-5}"

case $1 in
    i) pamixer -i ${step} ;;
    d) pamixer -d ${step} ;;
    m) pamixer -t ;;
    *) print_error ;;
esac