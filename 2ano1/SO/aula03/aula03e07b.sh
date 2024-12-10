#!/usr/bin/env bash
# Calculate the sum of a series of numbers.
SCORE="0"
SUM="0"
SCORES="0"
while true; do
	echo -n "Enter your score [0-10] ('q' to quit, 'r' to reset): "
	read SCORE;
	if (("$SCORE" < "0")) || (("$SCORE" > "10")); then
		echo "Try again: "
	elif [[ "$SCORE" == "q" ]]; then
		echo "Sum: $SUM."
		echo "Average: $(awk "BEGIN { printf(\"%.2f\", $SUM / $SCORES) }")."
		break
	elif [[ "$SCORE" == "r" ]]; then
		SUM="0"
		SCORES="0"
	else
		SUM=$((SUM + SCORE))
		SCORES=$((SCORES + 1));
	fi
done
echo "Exiting."
