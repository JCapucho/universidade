#!/usr/bin/env bash

if [ -z "$1" ]
  then
    echo "No target supplied"
fi

TGT="${1%/}"

echo "Building $TGT"

cd "$TGT"

[ -d "./build" ] || mkdir "./build"

neorg-pandoc "./$TGT.norg" | pandoc -s -f json \
    --template ../templates/eisvogel.latex -o "./build/$TGT.pdf" --listings

neorg-pandoc "./$TGT.norg" | pandoc -s -f json \
    --metadata title="$TGT" -o "./build/$TGT.html" --template ../templates/elegant_bootstrap_menu.html
