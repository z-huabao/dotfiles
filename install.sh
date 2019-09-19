#!/usr/bin/env bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, use sudo "$0" instead" 1>&2
   exit 1
fi

echo
echo '#-------------------------- prepare -----------------------------'
# mkdir -p -m 777 ~/.config/
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

sudo apt -y install make git curl python3-pip
sudo apt -y install software-properties-common


echo
echo '#-------------------------- zsh -----------------------------'
sudo apt install -y zsh zsh-antigen trash-cli lua5.2
mkdir -p -m 777 $plug_dir/antigen/bundles

antigen_pkg=$plug_dir/antigen/antigen.zsh
if [ ! -f $antigen_pkg ]; then
    curl -L git.io/antigen > $antigen_pkg
fi

chsh -s /bin/zsh  # use zsh as default shell

rm -r ~/.antigen
ln -s -f $plug_dir/antigen ~/.antigen
ln -s -f $dotf_dir/zsh/zshrc ~/.zshrc

vfile=~/.zshrc-var
if [ ! -f "$vfile" ]; then
    echo '# Please copy env Paths from ~/.bashrc to ~/.zshrc-var' > $vfile
    vi -O ~/.bashrc ~/.zshrc-var
else
    echo File $vfile has exists!
fi


echo
echo '#-------------------------- tmux -----------------------------'
sudo apt install -y tmux
git clone https://github.com/tmux-plugins/tpm $plug_dir/tmux/plugins/tpm \
    && bash $plug_dir/tmux/tpm/bindings/install_plugins

rm -r ~/.tmux
ln -s -f $plug_dir/tmux ~/.tmux
ln -s -f $dotf_dir/tmux/tmux.conf ~/.tmux.conf

echo
echo '#-------------------------- neovim -----------------------------'
add_ppa neovim-ppa/stable
sudo apt install -y neovim
sudo apt purge -y vim vim-gnome
sudo pip3 install --user jedi

mkdir -p -m 777 $plug_dir/nvim/plugins $plug_dir/nvim/autoload
rm -r ~/.config/nvim
ln -s -f $plug_dir/nvim ~/.config/nvim
ln -s -f $dotf_dir/nvim/init.vim ~/.config/nvim/init.vim

vim_plug=$plug_dir/nvim/autoload/plug.vim
if [ ! -f $vim_plug ]; then
    curl -fLo $vim_plug --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

nvim +PlugInstall +qall


echo
echo '#-------------------------- ranger -----------------------------'
sudo apt install -y ranger
sudo apt install -y caca-utils highlight atool w3m poppler-utils mediainfo

mkdir -p -m 777 ~/.config/ranger
ln -s -f $dotf_dir/ranger/rc.conf ~/.config/ranger/rc.conf


echo
echo '#-------------------------- fzf -----------------------------'
#sudo apt install -y fzf
git clone https://github.com/junegunn/fzf.git $plug_dir/fzf \
    && $plug_dir/fzf/install
ln -s -f $plug_dir/fzf ~/.fzf

echo
echo '#-------------------------- xkeysnail -----------------------------'
sudo pip3 install --user xkeysnail pyuserinput
xfile=~/.config/autostart/xkey.desktop
if [ ! -f "$xfile" ]; then
    echo Please change username and password in $xfile
    cp $dotf_dir/xkeysnail/xkey.desktop $xfile
    vi $xfile
else
    echo File $xfile has exists!
fi



echo
echo '#-------------------------- finish -----------------------------'
