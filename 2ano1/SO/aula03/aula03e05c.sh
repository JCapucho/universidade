#!/usr/bin/env bash
PROGRAM_NAME="$0"

POSITIONAL_ARGS=()

REMOVE_PREFIX=false

help() {
	if [ ! -z "$1" ]; then
		>&2 echo "Error: $1"
	fi

	>&2 echo "Usage: $PROGRAM_NAME [options] dir"
	>&2 printf "\n"
	>&2 echo "Options:"
	>&2 echo -e "\t-h, --help:\tShows this message"
	>&2 echo -e "\t-r, --remove:\tDoesn't add the \`new_\` prefix to the folder"

	if [ -z "$1" ]; then
		exit 0;
	else
		exit 1;
	fi
}

for arg in "$@"; do
	if [[ $arg == --* ]]; then
		case "${arg#--}" in
			help)
				help
				;;
			remove)
				REMOVE_PREFIX=true
				;;
			* )
				help "Unknown option ${arg}"
				;;
		esac
	elif [[ $arg == -* ]]; then
		for (( i=1; i<${#arg}; i++ )); do
			case "${arg:$i:1}" in
				h)
					help
					;;
				r)
					REMOVE_PREFIX=true
					;;
				* )
					help "Unknown option ${arg:$i:1}"
					;;
			esac
		done
	else
		POSITIONAL_ARGS+=("$arg");
	fi
done

POSITIONAL_ARGS_LENGTH="${#POSITIONAL_ARGS[@]}"

if [ "$POSITIONAL_ARGS_LENGTH" -ne 1 ]; then
	if [ "$POSITIONAL_ARGS_LENGTH" -lt 1 ]; then
		help "Not enough arguments"
	else
		help "Too many arguments"
	fi
fi

PREFIX="new_"

if [ "$REMOVE_PREFIX" = true ]; then
	PREFIX=""
fi

# For all the files in a folder, show their properties
for f in "$PREFIX${POSITIONAL_ARGS[0]}"/*; do
	file "$f"
done
