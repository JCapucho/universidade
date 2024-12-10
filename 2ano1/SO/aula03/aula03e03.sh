#!/usr/bin/env bash
# This script checks the existence of a file

if [ "$#" -ne 1 ]; then
	if [ "$#" -lt 1 ]; then
		>&2 echo "Error: Not enough arguments"
	else
		>&2 echo "Error: Too many arguments"
	fi

	>&2 echo "Usage: $0 file"
	exit 1;
fi

echo "Checking..."
if [[ -f "$1" ]] ; then
	echo "$1 existe."
else
	echo "$1 não existe"
fi
echo "...done."
