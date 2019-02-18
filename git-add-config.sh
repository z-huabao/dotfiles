#!/usr/bin/env bash

files="
    ./README.md
    ./*.sh
    ./others/*
    ./tmux/.tmux.conf
    ./vim/.vimrc
    ./zsh/.zshrc
"

for f in $files
do
    git add $f
done

if [ -z "$1" ]; then
    git commit -m "update config files"
else
    git commit -m $1
fi
#git push -u origin master
git push

echo -e "\nFinish\n"
