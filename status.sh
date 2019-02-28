#!/bin/sh

print_volume () {
	volume=$(pamixer --get-volume)
	if test "$volume" -gt 0
	then
		echo -e "VOL: ${volume}"
	else
		echo -e "VOL: MUTED"
	fi
}

print_date () {
	date=$(date "+%a %d-%m %T%:::z")
	echo -e "${date}"

}

print_temp(){
	test -f /sys/class/thermal/thermal_zone0/temp || return 0
	echo -e "TEMP: $(head -c 2 /sys/class/thermal/thermal_zone0/temp) C"
}

print_battery () {
	battery=$(awk '{ sum += $1 } END { print sum }' /sys/class/power_supply/BAT*/capacity)
	echo -e "BAT: ${battery}"
}

while true
do
	xsetroot -name " $(print_volume) | $(print_battery) | $(print_temp) | $(print_date) "
	sleep 1

done
