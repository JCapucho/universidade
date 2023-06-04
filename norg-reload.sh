#!/usr/bin/env bash

function build() {
    "$SCRIPT_DIR/nix/norg-builder.sh" "$1" "$SCRIPT_DIR/templates/Simple.html" "dist/index.html"
}

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if [[ $# -ne 1 ]]; then
    echo "Illegal number of parameters" >&2
    echo "Usage: norg-reload [norg file]" >&2
    exit 2
fi

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

mkdir -p dist
build "$1"

live-server \
    --verbose \
    --open="index.html" \
    --mount="/index.html:dist/index.html" \
    --mount="/resources:$SCRIPT_DIR/resources" &

echo "Watching '$1'"

fswatch -e ".*" -i "$1" -0 "$1" | while read -d "" event
do 
    build "$1" || true
done
