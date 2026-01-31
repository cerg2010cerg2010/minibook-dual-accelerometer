#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0+

errecho() {
	echo "$@" >&2
}

usage() {
	errecho "$(basename "$0") [old-state] new-state"
	errecho -e "\tChange tablet-mode state on Chuwi MiniBook X convertible laptop"
	errecho -e "\tValid states are: CLOSED, LAPTOP, TENT, TABLET"
}

if [ $# -eq 1 ]; then
	old_state=""
	new_state="$1"
elif [ $# -eq 2 ]; then
	old_state="$1"
	new_state="$2"
else
	usage
	exit 1
fi

case "$new_state" in
	# TODO: get device path from IIO firmware_node/path
	"CLOSED"|"LAPTOP")
		echo '\_SB.PC00.I2C3.ACC.CVTD 0' > /proc/acpi/call
		;; 
	"TENT"|"TABLET")
		echo '\_SB.PC00.I2C3.ACC.CVTT 0' > /proc/acpi/call
		;;
	*)
		errecho "Invalid tablet mode '$new_state'!"
		usage
		exit 1
		;;
esac

exit 0
