#!/usr/bin/env bash
if [ "$#" -ne 1 ]; then
	if [ "$#" -lt 1 ]; then
		>&2 echo "Error: Not enough arguments"
	else
		>&2 echo "Error: Too many arguments"
	fi

	>&2 echo "Usage: $0 dir"
	exit 1;
fi
# For all the files in a folder, show their properties
for f in $1/*; do
	file "$f"
done
