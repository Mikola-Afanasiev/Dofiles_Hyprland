#!/bin/bash

SAVE_DIR="$HOME/Screenshots"
mkdir -p "$SAVE_DIR"

FILENAME="screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
SAVE_PATH="$SAVE_DIR/$FILENAME"

grim "$SAVE_PATH"
if [ $? -ne 0 ]; then
    notify-send "Screenshot" "Error capturing screenshot."
    exit 1
fi

swappy -f "$SAVE_PATH"
if [ $? -eq 0 ]; then
    notify-send  -i "$SAVE_PATH" "Screenshot" "Edited and saved: $SAVE_PATH"
else
    notify-send  -i "$SAVE_PATH" "Screenshot" "Editing canceled. Saved: $SAVE_PATH"
fi

