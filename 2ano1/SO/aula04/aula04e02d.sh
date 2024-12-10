#!/usr/bin/env bash
function cmp {
	if [ "$1" -eq "$2" ]; then
		return 1
	elif [ "$1" -lt "$2" ]; then
		return 0
	else
		return 2
	fi
}

cmp "$1" "$2"
case $? in
	0)
		echo "$1 é menor que $2"
		;;
	1)
		echo "$1 é igual a $2"
		;;
	2)
		echo "$1 é maior que $2"
esac
