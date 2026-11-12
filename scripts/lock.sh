#!/usr/bin/env bash
set -u

dir=$(mktemp -d "${XDG_RUNTIME_DIR:-/tmp}/lock.XXXXXX")
trap 'rm -rf "$dir"' EXIT

args=()
for out in $(swaymsg -t get_outputs | jq -r '.[] | select(.active and .power != false) | .name'); do
    img="$dir/$out.png"
    if timeout 2 grim -o "$out" "$img" &&
        timeout 3 magick "$img" -resize 25% -blur 0x3 -resize 400% -fill black -colorize 30% "$img"; then
        args+=(-i "$out:$img")
    fi
done

swaylock -f -c 000000 -s fill \
    --indicator-idle-visible \
    --ring-color 2E3440 --key-hl-color ECEFF4 --line-color 88C0D0 \
    --inside-color 00000088 --separator-color 00000000 \
    --text-color ECEFF4 --text-caps-lock-color ECEFF4 \
    --show-failed-attempts \
    "${args[@]}" "$@"
