#!/bin/sh

OPACITY="50%"
SOURCE_DIR="./images"
OUTPUT_DIR="./static"


die () {
	[ -n "$1" ] && echo "$1"
	exit 1
}

[ -d "$OUTPUT_DIR" ] || mkdir -v "$OUTPUT_DIR"

for file in $(find "$SOURCE_DIR"); do
	if [ -f "$file" ]; then
		echo "$file:"
		basename="$(basename "$file" | sed 's/\(.*\)\.\(.*\)/\1/')"
		extension="$(basename "$file" | sed 's/\(.*\)\.\(.*\)/\2/')"
		dirname="$(dirname "$file")"

		echo "Creating resized version"
		resized="$OUTPUT_DIR/$file"
		convert "$file" -resize 'x1080>' "$OUTPUT_DIR/$file" || die

		if echo "$dirname" | grep '/headers$' > /dev/null; then
			echo "Creating header versions"
			light="$OUTPUT_DIR/$dirname/$basename-light.$extension"
			convert "$resized" -blur 0x16 -fill white -colorize "$OPACITY" "$light.temp" || die
			mv "$light.temp" "$light" || die
		fi
		echo
	elif [ -d "$file" ]; then
		mkdir -vp "$OUTPUT_DIR/$file" || die
		echo
	fi
done
