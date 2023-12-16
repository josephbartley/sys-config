#!/bin/bash

# this script will pull the configs from the repo and apply them to the localmachine
git pull

cp .zshrc ~/.zshrc
cp alacritty.yml ~/.config/alacritty/alacritty.yml
cp init.lua ~/.config/nvim/init.lua

