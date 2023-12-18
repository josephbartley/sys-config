#!/bin/bash

# this script will pull the configs from the repo and apply them to the localmachine
git pull

cp alacritty.yml ~/.config/alacritty/alacritty.yml
cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh
cp init.lua ~/.config/nvim/init.lua

