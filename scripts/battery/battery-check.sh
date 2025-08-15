#!/bin/bash

#Variables
battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

notify-send "Battery" "Your buttery capacity is $battery_capacity and status is $battery_status"
