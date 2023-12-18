#!/bin/bash

# this script will push the configs from the local machine to the repo
cp ~/.config/alacritty/alacritty.yml ./alacritty.yml
cp ~/.zshrc ./.zshrc
cp ~/.p10k.zsh ./.p10k.zsh
cp ~/.config/nvim/init.lua ./init.lua

git add . 
git commit -m "automatically updated"
git push
