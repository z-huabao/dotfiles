#!/usr/bin/env bash

files="
    README.md
    *.sh
    others/*
    tmux/.tmux.conf
    vim/.vimrc
    zsh/.zshrc
"

for f in $files
do
    git add $f
done

git commit -m "$1"
#git push -u origin master
#git push

