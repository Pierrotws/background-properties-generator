# Simple moded background maker

easy sh script to generate XmlBackground for gnome

that allows to encapsulate light & dark wallpapers.

## Usage

Only <BP_NAME> is mandatory to set. Other can be deducted or computed

By default, script will consider <BP_NAME>-d.jxl and <BP_NAME>-l.jxl 
in <BP_WP_DIR> (~/.local/share/backgrounds)

Minimal:
```bash
BP_NAME=test ./gen_background.sh
```

Complete:
```bash
BP_NAME=test BP_FILENAME_LIGHT=.. BP_FILENAME_DARK=.. BP_OPTIONS=zoom ./gen_background.sh
```
