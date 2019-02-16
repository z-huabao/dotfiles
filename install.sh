#/usr/bin/env bash

cdir=~/ubuntu-config

cd ~

ln -s -f $cdir/tmux/.tmux.conf && ln -s -f $cdir/tmux/.tmux
ln -s -f $cdir/vim/.vim && ln -s -f $cdir/vim/.vimrc
ln -s -f $cdir/zsh/.antigen && ln -s -f $cdir/zsh/.zshrc && ln -s -f $cdir/zsh/antigen.zsh

sudo apt install tmux vim zsh antigen trash-cli

sudo apt install python3-pip
sudo pip3 install xkeysnail

# use zsh as default shell
chsh -s /bin/zsh

# echo "replace bash to zsh in /etc/passwd" && sudo vim /etc/passwd


echo "\nFinish!\n"
