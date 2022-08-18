#!/usr/bin/env zsh

SCPT_HOME="${HOME}/git/configs/brew/"
cd "${SCPT_HOME}"

which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew tap Homebrew/bundle

if [ -f Brewfile ]
then
    brew bundle
else
    brew bundle dump
fi
