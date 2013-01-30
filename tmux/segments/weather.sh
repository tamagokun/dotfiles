#!/bin/bash
# Prints the current weather in Celsius, Fahrenheits or lord Kelvins. The forecast is cached and updated with a period of $update_period.

# Your location. Find a code that works for you:
# 1. Go to Yahoo weather http://weather.yahoo.com/
# 2. Find the weather for you location
# 3. Copy the last numbers in that URL. e.g. "http://weather.yahoo.com/united-states/california/newport-beach-12796587/" has the numbers "12796587"
# You location. Find a string that works for you by Googling on "weather in <location-string>"
location="2482955"

# Can be any of {c,f,k}.
unit="f"

tmp_file="/tmp/tmux-powerline_weather.txt"

get_condition_symbol() {
	local conditions=$(echo "$1" | tr '[:upper:]' '[:lower:]')
	case "$conditions" in
		"sunny" | "hot")
			hour=$(date +%H)
			if [ "$hour" -ge "22" -o "$hour" -le "5" ]; then
			#echo "☽"
			echo "☾"
			else
			#echo "☀"
			echo "☼"
			fi
			;;
		"rain" | "mixed rain and snow" | "mixed rain and sleet" | "freezing drizzle" | "drizzle" | "light drizzle" | "freezing rain" | "showers" | "mixed rain and hail" | "scattered showers" | "isolated thundershowers" | "thundershowers" | "light rain with thunder" | "light rain")
			#echo "☂"
			echo "☔"
			;;
		"snow" | "mixed snow and sleet" | "snow flurries" | "light snow showers" | "blowing snow" | "sleet" | "hail" | "heavy snow" | "scattered snow showers" | "snow showers" | "light snow" | "snow/windy" | "snow grains")
			#echo "☃"
			echo "❅"
			;;
		"cloudy" | "mostly cloudy" | "partly cloudy" | "partly cloudy/windy")
			echo "☁"
			;;
		"tornado" | "tropical storm" | "hurricane" | "severe thunderstorms" | "thunderstorms" | "isolated thunderstorms" | "scattered thunderstorms")
			#echo "⚡"
			echo "☈"
			;;
		"dust" | "foggy" | "fog" | "haze" | "smoky" | "blustery" | "mist")
			#echo "♨"
			#echo "﹌"
			echo "〰"
			;;
		"windy" | "fair/windy")
			#echo "⚑"
			echo "⚐"
			;;
		"clear" | "fair" | "cold")
			hour=$(date +%H)
			if [ "$hour" -ge "22" -o "$hour" -le "5" ]; then
			echo "☾"
			else
			echo "〇"
			fi
			;;
		*)
			echo "？"
			;;
	esac
}

read_tmp_file() {
	if [ ! -f "$tmp_file" ]; then
		return
	fi
	IFS_bak="$IFS"
	IFS=$'\n'
	lines=($(cat ${tmp_file}))
	IFS="$IFS_bak"
	degrees="${lines[0]}"
	conditions="${lines[1]}"
}

degree=""
if [ -f "$tmp_file" ]; then
	case $(uname -s) in
		"Linux")
			last_update=$(stat -c "%Y" ${tmp_file})
		;;
		"Darwin")
			last_update=$(stat -f "%m" ${tmp_file})
		;;
		"FreeBSD")
			last_update=$(stat -f "%m" ${tmp_file})
		;;
	esac
	time_now=$(date +%s)
	update_period=600

	up_to_date=$(echo "(${time_now}-${last_update}) < ${update_period}" | bc)
	if [ "$up_to_date" -eq 1 ]; then
		read_tmp_file
	fi
fi

if [ -z "$degree" ]; then
	if [ "$unit" == "k" ]; then
		search_unit="c"
	else
		search_unit="$unit"
	fi
	if [ "$PLATFORM" == "mac" ]; then
		search_location=$(echo "$location" | sed -e 's/[ ]/%20/g')
	else
		search_location=$(echo "$location" | sed -e 's/\s/%20/g')
	fi

	weather_data=$(curl --max-time 4 -s "http://weather.yahooapis.com/forecastrss?w=${search_location}&u=${search_unit}")
	if [ "$?" -eq "0" ]; then
		error=$(echo "$weather_data" | grep "problem_cause\|DOCTYPE");
		if [ -n "$error" ]; then
			echo "error"
			exit 1
		fi
		# <yweather:units temperature="F" distance="mi" pressure="in" speed="mph"/>
		unit=$(echo "$weather_data" | grep -EZo "<yweather:units [^<>]*/>" | sed 's/.*temperature="\([^"]*\)".*/\1/')
		condition=$(echo "$weather_data" | grep -EZo "<yweather:condition [^<>]*/>")
		# <yweather:condition  text="Clear"  code="31"  temp="66"  date="Mon, 01 Oct 2012 8:00 pm CST" />
		degree=$(echo "$condition" | sed 's/.*temp="\([^"]*\)".*/\1/')
		condition=$(echo "$condition" | sed 's/.*text="\([^"]*\)".*/\1/')
		echo "$degree" > $tmp_file
		echo "$condition" >> $tmp_file
	elif [ -f "$tmp_file" ]; then
		read_tmp_file
	fi
fi

if [ -n "$degree" ]; then
	if [ "$unit" == "k" ]; then
		degree=$(echo "${degree} + 273.15" | bc)
	fi
	condition_symbol=$(get_condition_symbol "$conditions")
	echo "${condition_symbol} ${degrees}°$(echo "$unit" | tr '[:lower]' '[:upper]')"
fi
