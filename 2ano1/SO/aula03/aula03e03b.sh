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

if ! [ -e "$1" ]; then
	echo "$1 não existe."
	exit 1
fi

TYPE="unknown file"

if [ -f "$1" ]; then TYPE="regular file"
elif [ -b "$1" ]; then TYPE="block dev file"
elif [ -c "$1" ]; then TYPE="char dev file"
elif [ -d "$1" ]; then TYPE="directory"
fi

echo "$1 is a $TYPE"

PERMS=""

if [ -r "$1" ]; then PERMS="${PERMS}r"; else PERMS="${PERMS}-"; fi
if [ -w "$1" ]; then PERMS="${PERMS}w"; else PERMS="${PERMS}-"; fi
if [ -x "$1" ]; then PERMS="${PERMS}x"; else PERMS="${PERMS}-"; fi

echo "$1 permissions: $PERMS"

echo "...done."
