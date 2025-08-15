#!/bin/bash

# Get battery status and capacity
get_battery_status() {
	battery_status=$(cat /sys/class/power_supply/BAT0/status)
	battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
}

# Update battery flags based on status and capacity
update_battery_flags() {
	declare -A battery_flags=(
		[charging]=False
		[discharging]=False
		[full]=False
		[super_low]=False
		[very_low]=False
		[low]=False
		[middle]=False
		[half]=False
		[almost_full]=False
		[full_capacity]=False
	)

	# Update charging state flags
	if [ "$battery_status" == "Charging" ]; then
		battery_flags[charging]=True
	elif [ "$battery_status" == "Discharging" ]; then
		battery_flags[discharging]=True
	elif [ "$battery_status" == "Full" ]; then
		battery_flags[full]=True
	fi

	# Update capacity level flags
	if ((battery_capacity < 5)); then
		battery_flags[super_low]=True
	elif ((battery_capacity < 10)); then
		battery_flags[very_low]=True
	elif ((battery_capacity < 20)); then
		battery_flags[low]=True
	elif ((battery_capacity < 50)); then
		battery_flags[middle]=True
	elif ((battery_capacity < 80)); then
		battery_flags[half]=True
	elif ((battery_capacity < 100)); then
		battery_flags[almost_full]=True
	else
		battery_flags[full_capacity]=True
	fi

	# Assign updated flags to variables
	battery_status_charging=${battery_flags[charging]}
	battery_status_discharging=${battery_flags[discharging]}
	battery_status_full=${battery_flags[full]}
	battery_capacity_super_low=${battery_flags[super_low]}
	battery_capacity_very_low=${battery_flags[very_low]}
	battery_capacity_low=${battery_flags[low]}
	battery_capacity_middle=${battery_flags[middle]}
	battery_capacity_half=${battery_flags[half]}
	battery_capacity_almost_full=${battery_flags[almost_full]}
	battery_capacity_full=${battery_flags[full_capacity]}
}

# Initial status and flags update
get_battery_status
update_battery_flags

# Battery check loop
while true; do
	get_battery_status

	# Notify if charging
	if [ "$battery_status" == "Charging" ] &&
		[ "$battery_status_charging" == "True" ] &&
		[ "$battery_status_discharging" == "False" ] &&
		[ "$battery_status_full" == "False" ]; then

		notify-send "Battery" "Your battery is charging"
		battery_status_charging=False
		battery_status_discharging=True
		battery_status_full=False

	# Notify if discharging
	elif [ "$battery_status" == "Discharging" ] &&
		[ "$battery_status_charging" == "False" ] &&
		[ "$battery_status_discharging" == "True" ] &&
		[ "$battery_status_full" == "False" ]; then

		notify-send "Battery" "Your battery is discharging"
		battery_status_charging=True
		battery_status_discharging=False
		battery_status_full=False

	# Notify if full
	elif [ "$battery_status" == "Full" ] &&
		[ "$battery_status_charging" == "False" ] &&
		[ "$battery_status_discharging" == "False" ] &&
		[ "$battery_status_full" == "False" ]; then

		notify-send "Battery" "Your battery is full, you don't need charging"
		battery_status_charging=False
		battery_status_discharging=False
		battery_status_full=True

	fi
  
  if ((battery_capacity < 5)); then
		battery_capacity_full=True
	elif ((battery_capacity < 10)); then
		battery_capacity_very_low=True
	elif ((battery_capacity < 20)); then
		battery_flags[low]=True
	elif ((battery_capacity < 50)); then
		battery_flags[middle]=True
	elif ((battery_capacity < 80)); then
		battery_flags[half]=True
	elif ((battery_capacity < 100)); then
		battery_flags[almost_full]=True
  fi
 
	sleep 30
done
