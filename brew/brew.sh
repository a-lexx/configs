#!/usr/bin/env bash

brew tap Homebrew/bundle

if [ -f Brewfile ]
then
brew bundle
else
brew bundle dump
fi
