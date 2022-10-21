#!/bin/sh

OPACITY="50%"
SOURCE_DIR="./images"
OUTPUT_DIR="./static"
UPLOAD_DIR="$OUTPUT_DIR/$SOURCE_DIR/uploads"


die () {
	[ -n "$1" ] && echo "$1"
	exit 1
}

[ -d "$OUTPUT_DIR" ] || mkdir -v "$OUTPUT_DIR"
[ -d "$UPLOAD_DIR" ] || mkdir -v "$UPLOAD_DIR"

for file in $(find "$SOURCE_DIR"); do
	if [ -f "$file" ]; then
		echo "$file:"
		filename="$(basename "$file")"
		dirname="$(dirname "$file")"
		basename="$(echo "$filename" | sed 's/\(.*\)\.\(.*\)/\1/')"
		extension="$(echo "$filename" | sed 's/\(.*\)\.\(.*\)/\2/')"

		echo "Creating resized version"
		resized="$OUTPUT_DIR/$file"
		convert "$file" -resize 'x1080>' "$OUTPUT_DIR/$file" || die

		echo "Adding file to uploads"
		if [ -f "$UPLOAD_DIR/$filename" ]; then
			echo "  File already exists"
		else
			upload="$UPLOAD_DIR/$filename"
			cp "$resized" "$upload"
		fi

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
