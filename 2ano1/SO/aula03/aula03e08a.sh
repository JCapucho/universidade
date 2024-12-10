#!/usr/bin/env bash
# select structure to create menus
PS3="Oi mate, choose an option ayeh: "
select arg in $@
do
	echo "You picked $arg ($REPLY)."
done
