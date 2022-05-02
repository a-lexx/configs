#!/usr/bin/env zsh

SCPT_HOME="${HOME}/git/configs/brew/"
cd "${SCPT_HOME}"

brew tap Homebrew/bundle

if [ -f Brewfile ]
then
    brew bundle
else
    brew bundle dump
fi
