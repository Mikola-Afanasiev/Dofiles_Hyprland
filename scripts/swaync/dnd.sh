#!/bin/bash
if swaync-client -D | grep -q "false"; then
  notify-send -i "$HOME"/.config/.dotfiles/cache/swaync/dnd-on.png "DND" "Your DND is on now"
  sleep 1
  swaync-client -dn
elif swaync-client -D | grep -q "true"; then
  swaync-client -df
  notify-send -i "$HOME"/.config/.dotfiles/cache/swaync/dnd-off.png "DND" "Your DND is off now"
fi
