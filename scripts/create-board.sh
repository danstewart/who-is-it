#!/usr/bin/env bash

# Build a new board of people to guess using https://randomuser.me/
# Downloads all images to ./site/images/<board_id> and replaces the URLs in the board file with the image IDs

set -e -u -o pipefail

count=20
fields="name,picture"
nationalities="au,br,ca,ch,de,dk,es,fi,fr,gb,ie,in,mx,nl,no,nz,rs,tr,us"
url="https://randomuser.me/api?results=${count}&inc=${fields}&noinfo&nat=${nationalities}"

board_id="$(mktemp -u XXXXXXXX)"
board_file="./site/boards/$board_id.json"

echo "Creating board $board_file with ${count} people..."
curl --silent $url > $board_file

echo "Downloading images..."
images=$(jq -r .results[].picture.large < $board_file)

# Ensure we don't have duplicate images
unique_image_count=$(echo "$images" | sort -u | grep -c "http")
if [[ $unique_image_count != $count ]]; then
    echo "Error: Duplicate images found, skipping..."
    rm -f $board_file
    exit 1
fi

mkdir -p ./site/images/${board_id}
for image in $images; do
    image_id="$(uuidgen)"
    image_file="./site/images/${board_id}/${image_id}.jpg"
    curl --silent $image -o $image_file
    perl -p -i -e "s|$image|$image_id|g" $board_file
done

echo "Completed!"
