#!/usr/bin/env bash

git add README.md *.sh others/* tmux/.tmux.conf vim/.vimrc zsh/.zshrc
git commit -m $1
#git push -u origin master
git push

