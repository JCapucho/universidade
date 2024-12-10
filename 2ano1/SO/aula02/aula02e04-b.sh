#!/usr/bin/env bash
echo "Todos os items em /etc:"
find /etc -maxdepth 1 -printf "%f\n"

printf "\n"

echo "Começam por a:"
find /etc -maxdepth 1 -name "a*" -printf "%f\n"

printf "\n"

echo "Começam por a e têm mais que 3 caracteres":
find /etc -maxdepth 1 -regextype egrep -regex ".*/a.{3,}" -printf "%f\n"

printf "\n"

echo "Contêm conf no nome":
find /etc -maxdepth 1 -name "*conf*" -printf "%f\n"
