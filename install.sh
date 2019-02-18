#!/usr/bin/env bash

paths="
    tmux/.tmux.conf
    tmux/.tmux
    vim/.vimrc
    vim/.vim
    zsh/.zshrc
    zsh/.antigen
    zsh/antigen.zsh
"

cd ~

for path in $paths
do
    ln -s -f ~/ubuntu-config/$path
done

# config tmux, zsh, vim
sudo apt install tmux vim zsh zsh-antigen trash-cli
# use zsh as default shell
chsh -s /bin/zsh


# config xkeysnail to autostart
sudo apt install python3-pip
sudo pip3 install xkeysnail

xfile=~/.config/autostart/xkey.desktop
if [ ! -f "$xfile" ]; then
    echo Please change username and password in $xfile
    cp ~/ubuntu-config/others/xkey.desktop ~/.config/autostart/
    vi $xfile
else
    echo File $xfile has exists!
fi


echo -e "\nFinish!\n"
