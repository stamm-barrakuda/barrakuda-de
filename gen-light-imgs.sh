#!/bin/sh

OPACITY="50%"

for image in $(find static/images -maxdepth 1 -type f -name "*.jpg" | grep -v "light"); do
	new_name="$(echo "$image" | sed 's/\.jpg//g')-light.jpg"
	echo "Converting $image into $new_name"
	convert "$image" -blur 0x16 -fill white -colorize "$OPACITY" "$new_name.temp" \
		&& mv "$new_name.temp" "$new_name"
done
