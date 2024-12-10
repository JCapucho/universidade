#!/usr/bin/env bash
#This script does a very simple test for checking disk space.

# `df -h`, report file system space usage in human readable format
# `awk '{print $5}'` - Print the fifth column (white space separated columns)
# `grep %` - Remove lines without the % symbol
# `grep -v Use` - Remove lines with the `Use` word
# `sort -n` - Sort lines numerically
# `tail -1` - Select the last line
# `cut -d "%" -f1 -` - Run the command `cut` reading from stdin (`-`) with the delimiter %
# 					   and selecting the first field.
space=$(df -h | awk '{print $5}' | grep % | grep -v Use | sort -n \
		| tail -1 | cut -d "%" -f1 -)

echo "largest occupied space = $space%"

largest=$(df | awk '{print $2 " " $1}' | tail -n +2 | sort -n -k1 \
		  | tail -1 | awk '{print $2 ": " $1}' | numfmt --field=2 --to=iec --from-unit=1024 )

echo "Largest partition $largest"
case $space in
	[0-6][0-9]) # espaço < 70%
		Message="All OK."
		;;
	[7-8][0-9] ) # 70% <= espaço < 90%
		Message="Cleaning out. One partition is $space % full."
		;;
	9[0-8] ) # 90% <= espaço < 99%
		Message="Better buy a new disk. One partition is $space % full."
		;;
	99 ) # espaço = 99%
		Message="I'm drowning here! There's a partition at $space %!"
		;;
	* )
		Message="I seem to be running with a non-existent disk..."
		;;
esac
echo $Message
