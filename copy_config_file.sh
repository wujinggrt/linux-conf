#!/bin/bash

read -p "Enter commit message:"
cp -r ~/.vimrc ~/.config/nvim/init.vim ~/.config/nvim/.vimconf ~/.tmux/.tmux.conf ~/.tmux.conf.local ~/.zshrc .

git add .
git commit -am "${REPLY}"
git gc
git push origin master
