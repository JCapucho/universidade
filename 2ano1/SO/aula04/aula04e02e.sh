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

read -p "Insira o primeiro número: " first
read -p "Insira o segundo número: " second

cmp "$first" "$second"
case $? in
	0)
		echo "$first é menor que $second"
		;;
	1)
		echo "$first é igual a $second"
		;;
	2)
		echo "$first é maior que $second"
esac
