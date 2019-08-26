#!/bin/bash

read -p "Enter commit message:"
cp ~/.vimrc ~/.tmux.conf ~/.tmux.conf.local ~/.zshrc ~/.ycm_extra_conf.py .
git add .
git commit -am "${REPLY}"
git gc
git push origin master
