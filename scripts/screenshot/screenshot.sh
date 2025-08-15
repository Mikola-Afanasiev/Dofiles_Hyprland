#!/bin/bash

SAVE_DIR="$HOME/Screenshots"
mkdir -p "$SAVE_DIR"

FILENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
SAVE_PATH="$SAVE_DIR/$FILENAME"

SELECTED_AREA=$(slurp)
if [ -z "$SELECTED_AREA" ]; then
    notify-send "Screenshot" "Canceled: no area selected."
    exit 1
fi

grim -g "$SELECTED_AREA" "$SAVE_PATH"
if [ $? -ne 0 ]; then
    notify-send "Screenshot" "Error capturing screenshot."
    exit 1
fi

notify-send -i "$SAVE_PATH" "Screenshot" "Saved: $SAVE_PATH"

swappy -f "$SAVE_PATH"
if [ $? -eq 0 ]; then
    notify-send -i "$SAVE_PATH" "Screenshot" "Edited and saved: $SAVE_PATH"
else
    notify-send -i "$SAVE_PATH" "Screenshot" "Editing canceled. Saved: $SAVE_PATH"
fi

