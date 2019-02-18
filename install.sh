#/usr/bin/env bash

cd ~

paths="
    tmux/.tmux.conf
    tmux/.tmux
    vim/.vimrc
    vim/.vim
    zsh/.zshrc
    zsh/.antigen
    zsh/antigen.sh
"

for path in $paths
do
    ln -s -f ~/ubuntu-config/$path
done

sudo apt install tmux vim zsh antigen trash-cli

sudo apt install python3-pip
sudo pip3 install xkeysnail

# use zsh as default shell
chsh -s /bin/zsh

# echo "replace bash to zsh in /etc/passwd" && sudo vim /etc/passwd


echo "\nFinish!\n"
