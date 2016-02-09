#!/bin/bash

echo "Sicher, dass Sie jetzt alle Commits für die Datei betrachten wollen? Stellen Sie möglichst sicher, dass keine Datei modified und keine staged ist."
read x

directory=$(dirname "$1")
cd "$directory"

tmp=$(git log "$1" | grep "^commit " | tail -r | cut -d \  -f2)
commits=($tmp)


echo "Sie werden gleich ${#commits[@]} Commits betrachten. Wollen Sie fortfahren?"
read x


for ((i = 1; i < ${#commits[@]}; i++)); do
	beforeindex=$((i-1))

	echo git difftool "${commits[$beforeindex]}" "${commits[$i]}" "$1"
    git difftool "${commits[$beforeindex]}" "${commits[$i]}" "$1"
done

git difftool

echo "Es wäre natürlich geil, wenn man das in einem HTML-File betrachten könnte ..."