#!/usr/bin/env bash
shopt -s extglob

case "$1|$2" in
	?([0-9])[0-9]"|"sec*)
		echo "Válido."
		;;
	* )
		echo "Não é válido"
		;;
esac
