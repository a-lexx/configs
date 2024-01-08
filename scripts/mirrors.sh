#!/usr/bin/env bash

LIST=$(curl -s https://archlinux.org/mirrors/status/json/ | jq -r '.urls | map(select(.country == "Ukraine" and .protocol == "https")) | sort_by(.score) | .[] | .url')

if [ "${LIST}" ]
then
    echo "## Ukraine" | sudo tee /etc/pacman.d/mirrorlist
    for list in $(curl -s https://archlinux.org/mirrors/status/json/ | jq -r '.urls | map(select(.country == "Ukraine" and .protocol == "https")) | sort_by(.score) | .[] | .url')
      do
          echo "Server = ${list}\$repo/os/\$arch" | sudo tee -a /etc/pacman.d/mirrorlist
      done

    echo 'Source list updated'
else
    echo 'List is empty'
    exit
fi