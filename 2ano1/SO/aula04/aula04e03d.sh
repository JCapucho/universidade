#!/usr/bin/env bash
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 [file]"
	exit 1
fi

numeros=()

while read -r line
do
	numeros+=("$line")
done < "$1"

last_idx=$(("${#numeros[@]}" - 1))

for i in $(seq 0 $last_idx); do
	small_idx="$i"

	for j in $(seq $((i + 1)) $last_idx); do
		if [ "${numeros[$j]}" -lt "${numeros[$small_idx]}" ]; then
			small_idx="$j"
		fi
	done

	if [ "$i" -ne "$small_idx" ]; then
		tmp="${numeros[$i]}"
		numeros["$i"]="${numeros[$small_idx]}"
		numeros["$small_idx"]="$tmp"
	fi
done

echo "${numeros[@]}"
