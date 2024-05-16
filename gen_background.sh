#!/bin/bash

if [ -z "$BP_NAME" ]; then
  echo "Missing only required parameter BP_NAME" >&2
  exit 1
fi

BP_DEST="${BP_DEST:-${HOME}/.local/share/gnome-background-properties}"

if [ -f "${BP_DEST}/${BP_NAME}.xml" ]; then
  echo "${BP_NAME} already exists." >&2
  exit 1
fi

BP_WP_DIR="${BP_WP_DIR:-${HOME}/.local/share/backgrounds}"
BP_FULL_NAME="${BP_FULL_NAME:-${BP_NAME^} Background}"
BP_FILENAME_LIGHT="${BP_FILENAME_LIGHT:-${BP_WP_DIR}/${BP_NAME}-l.jxl}"
BP_FILENAME_DARK="${BP_FILENAME_DARK:-${BP_WP_DIR}/${BP_NAME}-d.jxl}"
BP_OPTIONS="${BP_OPTIONS:-zoom}"
BP_SHADE_TYPE="${BP_SHADE_TYPE:-solid}"
# Scolor is black for now
BP_SCOLOR="${BP_SCOLOR:-#000000}"

if [ ! -f "$BP_FILENAME_LIGHT" ]; then
    echo "BP_FILENAME_LIGHT ($BP_FILENAME_LIGHT) does not exists" >&2
    echo "Create, or set BP_FILENAME_LIGHT to existing file"
    exit 1
fi
if [ ! -f "$BP_FILENAME_DARK" ]; then
    echo "BP_FILENAME_DARK ($BP_FILENAME_DARK) does not exists" >&2
    echo "Create, or set BP_FILENAME_DARK to existing file"
    exit 1
fi

# Use ImageMagick to get the average color in RGB
if [ -z "$BP_PCOLOR" ]; then
  BP_PCOLOR=$(convert "$BP_FILENAME_LIGHT" -resize 1x1 txt:- | grep -oP '#\w{6}')
fi

#Create, if required
mkdir -p ${BP_DEST};

cat <<EOF
Using:
BP_WP_DIR=${BP_WP_DIR}
BP_FULL_NAME=${BP_FULL_NAME}
BP_FILENAME_LIGHT=${BP_FILENAME_LIGHT}
BP_FILENAME_DARK=${BP_FILENAME_DARK}
BP_OPTIONS=${BP_OPTIONS}
BP_SHADE_TYPE=${BP_SHADE_TYPE}
BP_PCOLOR=${BP_PCOLOR}
BP_SCOLOR=${BP_SCOLOR}

Writing ${BP_DEST}/${BP_NAME}.xml
EOF

cat <<EOF > ${BP_DEST}/${BP_NAME}.xml
<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>${BP_FULL_NAME}</name>
    <filename>${BP_FILENAME_LIGHT}</filename>
    <filename-dark>${BP_FILENAME_DARK}</filename-dark>
    <options>${BP_OPTIONS}</options>
    <shade_type>${BP_SHADE_TYPE}</shade_type>
    <pcolor>${BP_PCOLOR}</pcolor>
    <scolor>${BP_SCOLOR}</scolor>
  </wallpaper>
</wallpapers>
EOF
