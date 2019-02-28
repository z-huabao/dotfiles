":silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
":PluginInstall  " uncomment this two lines when first use

"""""""""""""""""""""" 基本设置 """""""""""""""""""""""
set nocompatible          " 必须放在最前面
set t_Co=256
set background=dark
set nobackup		      " 取消备份
set noswapfile
set noundofile
set autoread              " 文件修改之后自动载入
set laststatus=2          " 状态栏配置
set hlsearch              " 高亮搜索命中的文本
set incsearch             " 随着键入即时搜索
set ignorecase            " 搜索时忽略大小写
set smartcase             " 有一个或以上大写字母时仍大小写敏感
set showcmd 		      " 在状态栏显示正在输入的命令
set showmatch		      " 显示括号配对情况
set autowrite		      " :next, :make 命令之前自动保存
set mouse=a		          " 允许使用鼠标
set number 	              " 设置行号
set relativenumber 	      " 设置相对行号
set backspace=2		      " 退格键可用
set smarttab		      " 退格键一次删掉4个空格
set autoindent		      " 缩进
set smartindent
set expandtab             " 填充Tab
set tabstop=4
set shiftwidth=4
set shiftround
set fdm=indent   	      " 代码折叠，光标在缩进下方时用za命令折叠或展开这块代码
set foldlevel=3 	      " 默认展开3层，zm全部折叠一层，zr全部展开一层，zn全部展开
"set t_ti= t_te=  	      " 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制
set cursorline            " 高亮光标行
"set vbs=4                 " 日志verbose
filetype indent on

syntax on                 " 开启语法检测
syntax enable             " 打开语法高亮

language messages zh_CN.utf-8            " 解决consle输出乱码
autocmd! bufwritepost .vimrc source %    " vimrc文件修改之后自动加载
autocmd BufWritePre * :%s/\s\+$//e       " 保存文件时自动删除行尾空格或Tab
autocmd BufWritePre * :%s/^$\n\+\%$//ge  " 保存文件时自动删除末尾空行
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
    \ | exe "normal! g'\"" | endif       " 打开文件时始终跳转到上次光标所在位置

""""""""""""""""""""""VUNDLE PLUGIN""""""""""""""""""""
" Vundle config plugin start
set rtp+=~/.vim/bundle/Vundle.vim
"filetype off
filetype plugin indent on
call vundle#begin()
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
Plugin 'yegappan/mru'                    " most recently used file
"Plugin 'w0rp/ale'                        " 代码检查
"Plugin 'kana/vim-submode'                " 创建新模式，例如window mode
call vundle#end()
" finally press command 'PluginInstall' to installk

"""""""""""""""""""""" blugin config """""""""""""""""""""""
" 配色设置
colorscheme molokai
let g:airline_theme='luna'

" tab补全设置
let g:jedi#popup_on_dot = 0

let g:NERDTreeChDirMode=1
let g:NERDTreeShowBookmarks=1 "显示书签
let g:NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$'] "设置忽略文件类型
let g:NERDTreeWinSize=25 "窗口大小
" close tree if only tree left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:indentLine_char='┆' "缩进指示线
let g:indentLine_enabled = 1

" custom comment
let g:NERDCustomDelimiters = {'kivy': {'left': '# '} }

" Markdown config
let g:mkdp_path_to_chrome='google-chrome'
let g:mkdp_auto_close=0

let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

"color pairs
let g:rbpt_colorpairs = [
                        \ ['brown',       'RoyalBlue3'],
                        \ ['Darkblue',    'SeaGreen3'],
                        \ ['darkgray',    'DarkOrchid3'],
                        \ ['darkgreen',   'firebrick3'],
                        \ ['darkcyan',    'RoyalBlue3'],
                        \ ['darkred',     'SeaGreen3'],
                        \ ['darkmagenta', 'DarkOrchid3'],
                        \ ['brown',       'firebrick3'],
                        \ ['gray',        'RoyalBlue3'],
                        \ ['darkmagenta', 'DarkOrchid3'],
                        \ ['Darkblue',    'firebrick3'],
                        \ ['darkgreen',   'RoyalBlue3'],
                        \ ['darkcyan',    'SeaGreen3'],
                        \ ['darkred',     'DarkOrchid3'],
                        \ ['red',         'firebrick3'],
                        \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" 代码检查
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
"let g:ale_sign_column_always = 1

" MRU
let MRU_File = '~/.cache/vim_mru'
nmap <leader>f :MRU<CR>


"""""""""""""""""""""""""KEY MAPPING""""""""""""""""""""

" F2切换行号显示
nnoremap <F2> :set nonu!<CR>:set relativenumber!<CR>

" F3开启和关闭树
nmap <F3> :NERDTreeToggle<CR>

" F4 注释
map <F4> <leader>ci<CR>

" F5运行脚本
nmap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        :call RunCpp
    elseif &filetype == 'h'
        :call RunCpp
    elseif &filetype == 'cpp'
        :call RunCpp
    elseif &filetype == 'hpp'
        :call RunCpp
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        exec "!time bash %"
    elseif &filetype == 'python'
        :call RunPython()
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    elseif &filetype == 'js'
        exec "!time gjs-console %"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    endif
endfunc

func! RunCpp()
    exec "!g++ % -o %<"
    exec "!time ./%<"
    ":cw
endfunc

func! RunPython()
    ":compiler pyunit
    if search("python3")
        exec '!time python3 %'
        ":set makeprg=python3\ %
    else
        exec '!time python2 %'
        ":set makeprg=python2\ %
    endif
    ":make && cw
endfunc

" <F6>
nnoremap <F6> :Autoformat<CR>

" <F7>
nmap <silent> <F7> <Plug>MarkdownPreview
" <F8>
nmap <silent> <F8> <Plug>StopMarkdownPreview

" 空格翻页
nnoremap <Space> <C-f>
nnoremap <Backspace> <C-b>
vnoremap <Space> <C-f>
vnoremap <Backspace> <C-b>

" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

" 映射切换tab的键位
nnoremap [t :tabp<CR>
nnoremap ]t :tabn<CR>

" normal模式下Ctrl+c全选并复制到系统剪贴板(linux必须装有vim-gnome)
nmap <C-c> gg"+yG

" visual模式下Ctrl+c复制、ctrl+x剪切选中内容到剪贴板
vmap <C-c> "+y
vmap <C-x> x:let @+=@"<CR>

" Ctrl+v原样粘贴剪切板内容
inoremap <C-v> <ESC>"+pa

" w!!写入只读文件
cmap w!! w !sudo tee >/dev/null %:p

" 给当前单词添加引号
nnoremap "" viw<esc>a"<esc>hbi"<esc>lel
nnoremap '' viw<esc>a'<esc>hbi'<esc>lel

" 自动匹配三引号
inoremap ''' ''''''<C-o>2h
inoremap """ """"""<C-o>2h

" 在Normal Mode和Visual/Select Mode下，利用Tab键和Shift-Tab键来缩进文本
nnoremap <tab> >>
nnoremap <S-tab> <<
vnoremap <tab> >gv
vnoremap <S-tab> <gv
vnoremap > >gv
vnoremap < <gv

" 分割窗口Ctrl+w +v or +s
nnoremap <Esc>- <C-w>s
nnoremap <Esc>\ <C-w>v
" quicker window switching
" 关闭窗口Ctrl+w  +q
nnoremap <Esc> <C-w>
"nnoremap <Esc>h <C-w>h
"nnoremap <Esc>j <C-w>j
"nnoremap <Esc>k <C-w>k
"nnoremap <Esc>l <C-w>l

" quicker window resize
nnoremap <Esc>Left  <C-w>3<
nnoremap <Esc>Down  <C-w>3-
nnoremap <Esc>Up    <C-w>3+
nnoremap <Esc>Right <C-w>3>


" emoji
inoremap <C-e> <C-X><C-U>

" 滚动， ESC 就是Alt键
nnoremap <Down> 4<C-e>
nnoremap <Up> 4<C-y>
"nnoremap <Down> 4j
"nnoremap <Up> 4k
nnoremap <Left> 4h
nnoremap <Right> 4l

" Shift+y copy to end of current line
nnoremap Y y$

autocmd FileType python nnoremap <buffer> dp Oimport ipdb; ipdb.set_trace()<C-[>
autocmd FileType python nnoremap <buffer> d/ O#!/usr/bin/env python3<C-[>
autocmd FileType sh nnoremap <buffer> d/ O#!/usr/bin/env bash<C-[>
