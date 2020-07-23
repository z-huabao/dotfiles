#!/usr/bin/env bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, use sudo "$0" instead" 1>&2
   exit 1
fi

echo
echo '#-------------------------- prepare -----------------------------'
# mkdir -p -m 777 $home/.config/
dotf_dir=$PWD
cd ..
mkdir -p -m 777 plugins && cd plugins
plug_dir=$PWD

home=$(eval echo ~${SUDO_USER})
uname=${home##/*/}
echo $home $uname

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

sudo apt -y install make git curl wget python3-pip goldendict
sudo apt -y install software-properties-common


echo
echo '#-------------------------- zsh -----------------------------'
sudo apt install -y zsh zsh-antigen lua5.2 trash-cli
mkdir -p -m 777 $plug_dir/antigen/ $plug_dir/antigen/bundles

antigen_pkg=$plug_dir/antigen/antigen.zsh
if [ ! -f $antigen_pkg ]; then
    sudo -u $uname curl -L git.io/antigen > $antigen_pkg
fi

# use zsh as default shell
chsh -s /bin/zsh

rm -r $home/.antigen
ln -s -f $plug_dir/antigen $home/.antigen
ln -s -f $dotf_dir/zsh/zshrc $home/.zshrc

vfile=$home/.zshrc-var
if [ ! -f "$vfile" ]; then
    echo '# Please copy env Paths from ~/.bashrc to ~/.zshrc-var' > $vfile
    sudo -u $uname vi -O $home/.bashrc $home/.zshrc-var
#    chmod 777 $vfile
else
    echo File $vfile exist!
fi


echo
echo '#-------------------------- tmux -----------------------------'
sudo apt install -y tmux
mkdir -p -m 777 $plug_dir/tmux $plug_dir/tmux/plugins
sudo -u $uname git clone https://github.com/tmux-plugins/tpm $plug_dir/tmux/plugins/tpm
sudo -u $uname bash $plug_dir/tmux/plugins/tpm/bindings/install_plugins

rm -r $home/.tmux
ln -s -f $plug_dir/tmux $home/.tmux
ln -s -f $dotf_dir/tmux/tmux.conf $home/.tmux.conf

echo
echo '#-------------------------- neovim -----------------------------'
sudo apt install -y neovim

# pip3 install --user neovim jedi pylint
sudo apt install -y nodejs python3-neovim python3-jedi python3-pylint
sudo apt install -y npm
sudo apt purge -y vim vim-gnome
sudo -u $uname curl -sL install-node.now.sh | sh

mkdir -p -m 777 $plug_dir/nvim/ $plug_dir/nvim/plugins $plug_dir/nvim/autoload
rm -r $home/.config/nvim
ln -s -f $plug_dir/nvim $home/.config/nvim
ln -s -f $dotf_dir/nvim/init.vim $home/.config/nvim/init.vim
ln -s -f $dotf_dir/nvim/ideavimrc $home/.ideavimrc

vim_plug=$plug_dir/nvim/autoload/plug.vim
if [ ! -f $vim_plug ]; then
    echo "$vim_plug not exists, get plug.vim ... ..."
    sudo -u $uname wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
                            -x -O $vim_plug
fi

nvim +PlugInstall +qall
#nvim +CocCommand python.setInterpreter


echo
echo '#-------------------------- ranger -----------------------------'
sudo apt install -y ranger
sudo apt install -y caca-utils highlight atool w3m poppler-utils mediainfo

mkdir -p -m 777 $home/.config/ranger
ln -s -f $dotf_dir/ranger/rc.conf $home/.config/ranger/rc.conf


echo
echo '#-------------------------- fzf -----------------------------'
#sudo apt install -y fzf

if [ ! -d $plug_dir/fzf ]; then
    echo "$plug_dir/fzf not exists, git cloning ... ..."
    mkdir -p -m 777 $plug_dir/fzf
    sudo -u $uname git clone https://github.com/junegunn/fzf.git $plug_dir/fzf \
        && $plug_dir/fzf/install
fi
echo "relink $plug_dir/fzf to $home/.fzf"
rm -r $home/.fzf
ln -s -f $plug_dir/fzf $home/.fzf

echo
echo '#-------------------------- xkeysnail -----------------------------'
sudo pip3 install --user xkeysnail pyuserinput
xfile="$home/.config/autostart/xkey.desktop"
if [ ! -f $xfile ]; then
    echo "Please change uname and password in $xfile"
    sudo -u $uname cp $dotf_dir/xkeysnail/xkey.desktop $xfile && vi $xfile
else
    echo File $xfile has exists, do not copy
fi


#chmod -R 777 $plug_dir
#chown -R root:root $plug_dir/antigen/bundles
#chmod -R 755 $plug_dir/antigen/bundles

echo
echo '#-------------------------- finish -----------------------------'
