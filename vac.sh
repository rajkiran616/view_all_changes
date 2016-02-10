#!/bin/bash

if [ $# -eq 0 ]; then
    cat README.md
    exit
fi

directory=$(dirname "$1")
cd "$directory"

tmp=$(git log "$1" | grep "^commit " | tail -r | cut -d \  -f2)
commits=($tmp)


echo "You will view ${#commits[@]} commits shortly. Press enter to continue."
read x


for ((i = 1; i < ${#commits[@]}; i++)); do
	beforeindex=$((i-1))

	echo git difftool "${commits[$beforeindex]}" "${commits[$i]}" "$1"
    git difftool "${commits[$beforeindex]}" "${commits[$i]}" "$1"
done

git difftool

# TODO
# View all changes in an HTML-File