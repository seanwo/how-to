#!/bin/bash

#cleanup resource forks and desktop services store files in the media folders

declare -a extensions=("._*" ".DS_Store")
declare -a folders=("/srv/mergerfs/mergerfs-pool1")
for f in "${folders[@]}"
do
    for i in "${extensions[@]}"
    do
        find $f -type f -name "$i" -exec rm {} \;
    done
done

#cleanup extra files in downloaded video content folders

declare -a extensions=("*.exe" "*.db" "*.jpg" "*.txt")
declare -a folders=("/srv/mergerfs/mergerfs-pool1/Movies" "/srv/mergerfs/mergerfs-pool1/Shows")
for f in "${folders[@]}"
do
    for i in "${extensions[@]}"
    do
        find $f -type f -name "$i" -exec rm {} \;
    done
    find $f -type d -empty -delete
done
