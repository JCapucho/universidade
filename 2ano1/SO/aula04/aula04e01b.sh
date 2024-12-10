#!/usr/bin/env bash
function imprime_msg()
{
	echo "A minha primeira funcao"
	return 0
}

function imprime_info()
{
	echo "Data: $(date)"
	echo "PC: $(hostname)"
	echo "Utilizador: $(whoami)"
	return 0
}

imprime_msg
imprime_info
