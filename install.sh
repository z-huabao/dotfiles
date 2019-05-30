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

rm ~/.antigen/init.zsh

# config tmux, zsh, vim
sudo apt install -y tmux vim vim-gnome zsh zsh-antigen trash-cli lua5.2
# use zsh as default shell
chsh -s /bin/zsh


# config xkeysnail to autostart
sudo apt install -y python3-pip
sudo pip3 install xkeysnail, pyuserinput

xfile=~/.config/autostart/xkey.desktop
if [ ! -f "$xfile" ]; then
    echo Please change username and password in $xfile
    cp ~/ubuntu-config/others/xkey.desktop ~/.config/autostart/
    vi $xfile
else
    echo File $xfile has exists!
fi

vfile=~/.zshrc-var
if [ ! -f "$vfile" ]; then
    echo '# Please copy env Paths from ~/.bashrc to ~/.zshrc-var' > $vfile
    vi -O ~/.bashrc ~/.zshrc-var
else
    echo File $vfile has exists!
fi



echo -e "\nFinish!\n"
