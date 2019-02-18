source ~/ubuntu-config/zsh/antigen.zsh

antigen use oh-my-zsh                           # 加载oh-my-zsh库
antigen theme robbyrussell                      # 加载主题

# 加载原版oh-my-zsh中的功能(robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle cp                                # 复制进度条
antigen bundle extract                           # 解压
#antigen bundle vi-mode

antigen bundle zsh-users/zsh-syntax-highlighting # 语法高亮功能
antigen bundle zsh-users/zsh-autosuggestions     # 代码提示功能
antigen bundle zsh-users/zsh-completions         # 自动补全功能

antigen bundle skywind3000/z.lua                 # 快速切换目录

# 保存更改
antigen apply

# -------------------- map keys --------------------------
bindkey -e
alias cp="cp -i"
alias rm="trash"

# tmux
alias tmnew="tmux new -s"
alias tmkill="tmux kill-session -t"
alias tmatt="tmux attach-session -t"
alias tmls="tmux ls"

# shortcut
alias run-xkey="nohup sudo xkeysnail ~/ubuntu-config/others/xkeysrc.py > /tmp/xkeys.out "

# add by zhb
#export HIST_STAMPS="yyyy-mm-dd"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/.mujoco/mjpro150/bin
export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/qt5:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/intel/mkl/lib/intel64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

export PATHONPATH=/home/zhb/anaconda2/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH=/opt/deep_learning/caffe-fast-rcnn/python:$PYTHONPATH
export PYTHONPATH=/opt/deep_learning/caffe-ssd/python:$PYTHONPATH  # python3 ssd_caffe
export PYTHONPATH=/opt/deep_learning/tf-models/research:$PYTHONPATH
export PYTHONPATH=/opt/deep_learning/tf-models/research/slim:$PYTHONPATH
# export PYTHONPATH=/opt/deep_learning/tensorflow/tensorflow/contrib/slim:$PYTHONPATH

export CPLUS_INCLUDE_PATH=/usr/include/python2.7:$CPLUS_INCLUDE_PATH
export NDK_HOME=/home/zhb/Android/Sdk/ndk-bundle

export PATH=$NDK_HOME:$PATH
export PATH=/usr/local/cuda/bin:$PATH
export PATH=/home/zhb/anaconda3/bin:$PATH
export PATH=/home/zhb/anaconda2/bin:$PATH
export PATH=/opt/android-studio/bin:$PATH
export PATH=/opt/deep_learning/caffe-ssd/build/tools:$PATH

