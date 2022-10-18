#!/bin/sh

OPACITY="50%"

for image in $(find header_images -maxdepth 1 -type f -name "*.jpg" | grep -v "light"); do
	basename="$(echo "$image" | sed 's/.*\///g;s/\.jpg//g')"
	echo "$basename:"
	name="static/images/headers/$basename.jpg"
	light_name="static/images/headers/$basename-light.jpg"
	echo "Resizing $image into $name"
	convert "$image" -resize x1080 "$name"
	echo "Generating light version for $name in $light_name"
	convert "$name" -blur 0x16 -fill white -colorize "$OPACITY" "$light_name.temp" \
		&& mv "$light_name.temp" "$light_name"
	echo
done
