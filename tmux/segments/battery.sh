# from https://github.com/richoH/dotfiles/blob/master/bin/battery.
#!/bin/sh

HEART_FULL=♥
HEART_EMPTY=♡
NUM_HEARTS=5

cutinate()
{
	perc=$1
	inc=$(( 100 / $NUM_HEARTS))

	for i in `seq $NUM_HEARTS`; do
		if [ $perc -lt 100 ]; then
			echo $HEART_EMPTY
		else
			echo $HEART_FULL
		fi
		echo " "
		perc=$(( $perc + $inc ))
	done
}

linux_get_bat ()
{
	bf=$(cat $BAT_FULL)
	bn=$(cat $BAT_NOW)
	echo $(( 100 * $bn / $bf ))
}

freebsd_get_bat ()
{
	echo "$(sysctl -n hw.acpi.battery.life)"
}

battery_status()
{
case $(uname -s) in
	"Linux")
		BATPATH=/sys/class/power_supply/BAT0
		STATUS=$BATPATH/status
		BAT_FULL=$BATPATH/charge_full
		BAT_NOW=$BATHPATH/energy_now
		if [ "$1" = `cat $STATUS` -o "$1" = "" ]; then
			linux_get_bat
		fi
		;;
	"FreeBSD")
		STATUS=`sysctl -n hw.acpi.battery.state`
		case $1 in
			"Discharging")
				if [ $STATUS -eq 1 ]; then
					freebsd_get_bat
				fi
				;;
			"Charging")
				if [ $STATUS -eq 2 ]; then
					freebsd_get_bat
				fi
				;;
			"")
				freebsd_get_bat
				;;
		esac
		;;
	"Darwin")
		ioreg -c AppleSmartBattery -w0 | \
		grep -o '"[^"]*" = [^ ]*' | \
		sed -e 's/= //g' -e 's/"//g' | \
		sort | \
		while read key value; do
			case $key in
				"MaxCapacity")
					export maxcap=$value;;
				"CurrentCapacity")
					export curcap=$value;;
				"ExternalConnected")
					export extconnect=$value;;
			esac
			if [[ -n $maxcap && -n $curcap && -n $extconnect ]]; then
				BATTERY_ICON=$HEART_EMPTY
				charge=$(( 100 * $curcap / $maxcap ))
				if [[ "$extconnect" == "Yes" ]]; then
					BATTERY_ICON=$HEART_FULL
					echo "$charge"
				else
					if [[ $charge -lt 50 ]]; then
						echo "#[fg=red]"
					fi
					echo "$charge"
				fi
				break
			fi
		done
esac
}

status=$(battery_status)

if [ -n "$CUTE_BATTERY_INDICATOR" ]; then
	echo $(cutinate $status)
else
	echo "${HEART_FULL} ${status}%"
	#echo "⛁ ${BATTERY_STATUS}%"
fi
