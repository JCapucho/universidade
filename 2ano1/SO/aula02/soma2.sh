#!/usr/bin/env bash
if [[ "$#" -ne "2" ]]; then
	echo "Usage: $0 num1 num2"
	exit 1
fi

echo $(("$1" + "$2"))
