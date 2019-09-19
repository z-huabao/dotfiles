#!/usr/bin/env bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, use sudo "$0" instead" 1>&2
   exit 1
fi

#-------------------------- prepare -----------------------------
dotf_dir=$PWD
cd ..
mkdir -p -m 777 plugins && cd plugins
plug_dir=$PWD

add_ppa() {
  count=0
  for i in "$@"; do
    grep -h "^deb.*$i" /etc/apt/sources.list.d/* > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
      echo "Adding ppa:$i"
      sudo add-apt-repository -y ppa:$i
      count=`expr $count + 1`
    else
      echo "ppa:$i already exists"
    fi
  done

  if [ $count -gt 0 ]; then
    sudo apt update
  fi
}

sudo apt -y install make git python3-pip
sudo apt -y install software-properties-common


#-------------------------- zsh -----------------------------
sudo apt install -y zsh zsh-antigen trash-cli lua5.2
mkdir -p -m 777 ~/.antigen/ $plug_dir/antigen/
curl -L git.io/antigen > $plug_dir/antigen/antigen.zsh
chsh -s /bin/zsh  # use zsh as default shell

rm ~/.antigen/bundles
ln -s -f $plug_dir/antigen ~/.antigen/bundles
ln -s -f $dotf_dir/zsh/zshrc ~/.zshrc

vfile=~/.zshrc-var
if [ ! -f "$vfile" ]; then
    echo '# Please copy env Paths from ~/.bashrc to ~/.zshrc-var' > $vfile
    vi -O ~/.bashrc ~/.zshrc-var
else
    echo File $vfile has exists!
fi


#-------------------------- tmux -----------------------------
sudo apt install -y tmux
git clone https://github.com/tmux-plugins/tpm $plug_dir/tmux/tpm \
    && bash $plug_dir/tmux/tpm/bindings/install_plugins

mkdir -p -m 777 ~/.tmux/
rm ~/.tmux/plugins
ln -s -f $plug_dir/tmux ~/.tmux/plugins
ln -s -f $dotf_dir/tmux/tmux.conf ~/.tmux.conf

#-------------------------- neovim -----------------------------
add_ppa neovim-ppa/stable
sudo apt install -y neovim
sudo apt purge -y vim vim-gnome

mkdir -p -m 777 ~/.config/nvim $plug_dir/nvim
rm ~/.config/nvim/plugins
ln -s -f $plug_dir/nvim ~/.config/nvim/plugins
ln -s -f $dotf_dir/vim/init.vim ~/.config/nvim/init.vim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall


#-------------------------- ranger -----------------------------
sudo apt install -y ranger
sudo apt install -y caca-utils highlight atool w3m poppler-utils mediainfo
ln -s -f $dotf_dir/ranger/rc.conf ~/.config/ranger/rc.conf


#-------------------------- fzf -----------------------------
#sudo apt install -y fzf
git clone https://github.com/junegunn/fzf.git $plug_dir/fzf \
    && $plug_dir/fzf/install
ln -s -f $plug_dir/fzf ~/.fzf

#-------------------------- xkeysnail -----------------------------
sudo pip3 install xkeysnail pyuserinput
xfile=~/.config/autostart/xkey.desktop
if [ ! -f "$xfile" ]; then
    echo Please change username and password in $xfile
    cp $dotf_dir/xkeysnail/xkey.desktop $xfile
    vi $xfile
else
    echo File $xfile has exists!
fi



#-------------------------- finish -----------------------------
echo -e "\nFinish!\n"
