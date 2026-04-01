# Fix HDMI audio output
set hdmi_card (pactl list cards | awk '/Name:/{name=$2} /hdmi-output-0/ && /, available\)/{print name; exit}')
if test -n "$hdmi_card"
    pactl set-card-profile $hdmi_card output:hdmi-stereo+input:analog-stereo
end