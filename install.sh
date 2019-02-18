#!/usr/bin/env bash

cd ~

paths="
    tmux/.tmux.conf
    tmux/.tmux
    vim/.vimrc
    vim/.vim
    zsh/.zshrc
    zsh/.antigen
    zsh/antigen.zsh
"

for path in $paths
do
    ln -s -f ~/ubuntu-config/$path
done

sudo apt install tmux vim zsh antigen trash-cli

sudo apt install python3-pip
sudo pip3 install xkeysnail
# add `nohup bash ~/ubuntu-config/others/run-xkey.sh 'password' > /tmp/run-xkey.out &`
# to gnome-session-properties to auto start xkey

# use zsh as default shell
chsh -s /bin/zsh

# echo "replace bash to zsh in /etc/passwd" && sudo vim /etc/passwd


echo -e "\nFinish!\n"
