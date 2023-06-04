PANDOC="${PANDOC:-pandoc}"
PANDOC_NORG_RS="${PANDOC_NORG_RS:-pandoc-norg-rs}"

if [[ $# -ne 3 ]]; then
    echo "Illegal number of parameters" >&2
    echo "Usage: norg-builder [norg file] [templates] [output file]" >&2
    exit 2
fi

"$PANDOC_NORG_RS" "$1" | "$PANDOC" \
  -s --toc \
  -f 'json' \
  --metadata lang=pt-PT \
  --template "$2" \
  --mathjax \
  -o "$3"
