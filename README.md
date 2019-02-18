# ubuntu-config

我的开发套件(tmux、vim、zsh)及插件配置：

还有[xkeysnail](https://github.com/mooz/xkeysnail)用于整个系统的[快捷键](https://github.com/z-huabao/ubuntu-config/blob/master/others/xkeysrc.py)映射

## install:

    cd ~
    git clone https://github.com/z-huabao/ubuntu-config
    cd ubuntu-config && ./install.sh

## tmux cloned plugins:

    set -g @plugin 'tmux-plugins/tpm'
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'tmux-plugins/tmux-sessionist'
    set -g @plugin 'tmux-plugins/tmux-copycat'
    set -g @plugin 'tmux-plugins/tmux-resurrect'
    set -g @plugin 'tmux-plugins/tmux-continuum'
    set -g @plugin 'tmux-plugins/tmux-yank'
    set -g @plugin 'nhdaly/tmux-better-mouse-mode'
    set -g @plugin 'tmux-plugins/tmux-logging'

## zsh cloned plugins(use antigen):

    antigen use oh-my-zsh                            # 加载oh-my-zsh库
    antigen theme robbyrussell                       # 加载主题
    antigen bundle git
    antigen bundle heroku
    antigen bundle pip
    antigen bundle lein
    antigen bundle command-not-found
    antigen bundle cp                                # 复制进度条
    antigen bundle extract                           # 解压
    antigen bundle zsh-users/zsh-syntax-highlighting # 语法高亮功能
    antigen bundle zsh-users/zsh-autosuggestions     # 代码提示功能
    antigen bundle zsh-users/zsh-completions         # 自动补全功能
    antigen bundle skywind3000/z.lua                 # 快速切换目录

## vim cloned plugins:

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'yianwillis/vimcdoc'              " 中文手册
    Plugin 'ervandew/supertab'               " tab 自动补全
    Plugin 'tomasr/molokai'                  " 配色
    Plugin 'davidhalter/jedi-vim'            " 自动补全代码
    "Plugin 'Valloric/YouCompleteMe'         " 自动补全（加载太慢了）
    Plugin 'vim-airline/vim-airline'         " 底部状态栏
    Plugin 'vim-airline/vim-airline-themes'   " 底部状态栏主题
    Plugin 'scrooloose/nerdtree'             " 目录树
    Plugin 'Yggdroot/indentLine'             " 缩进指示
    Plugin 'jiangmiao/auto-pairs'            " 自动补全括号
    Plugin 'scrooloose/nerdcommenter'        " 批量注释 F4
    Plugin 'iamcco/markdown-preview.vim'     " markdown预览
    Plugin 'Chiel92/vim-autoformat'          " pep8 风格格式化代码
    Plugin 'kien/rainbow_parentheses.vim'    " 不同颜色匹配括号
    "Plugin 'w0rp/ale'                        " 代码检查
    "Plugin 'kana/vim-submode'                " 创建新模式，例如window mode
