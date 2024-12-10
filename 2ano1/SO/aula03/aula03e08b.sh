#!/usr/bin/env bash
# select structure to create menus
PS3="Oi mate, choose an option ayeh: "
select arg in $@
do
	if [ -z "$arg" ]; then
		exit 1
	fi

	echo "You picked $arg ($REPLY)."
done
