""""""""""""""""""""""BASE SETTING""""""""""""""""""""
"language messages zh_CN.utf-8            " 解决consle输出乱码
set noswapfile
set t_Co=256
set autoindent		      " 缩进
set shiftwidth=4
set expandtab             " 填充Tab
set fdm=indent   	      " 代码折叠，光标在缩进下方时用za命令折叠或展开这块代码
set foldlevel=3 	      " 默认展开3层，zm全部折叠一层，zr全部展开一层，zn全部展开
set cursorline            " 高亮光标行
set autoread              " 文件修改之后自动载入
set autowrite		      " :next, :make 命令之前自动保存
set mouse=a		          " 允许使用鼠标
set number 	              " 设置行号
set relativenumber 	      " 设置相对行号
"set vbs=4                 " 日志verbose
autocmd! bufwritepost init.vim source %    " vimrc文件修改之后自动加载
autocmd BufWritePre * :%s/\s\+$//e       " 保存文件时自动删除行尾空格或Tab
autocmd BufWritePre * :%s/^$\n\+\%$//ge  " 保存文件时自动删除末尾空行
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
    \ | exe "normal! g'\"" | endif       " 打开文件时始终跳转到上次光标所在位置


""""""""""""""""""""""PLUGINS""""""""""""""""""""
call plug#begin('~/.config/nvim/plugins')

" 配色
Plug 'tomasr/molokai'
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has('termguicolors'))
  set termguicolors
endif

" 状态栏
Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'one'}
set laststatus=2          " 状态栏配置

" json file
Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" 目录树
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let g:NERDTreeChDirMode=1
let g:NERDTreeHijackNetrw = 0  " add this line if you use NERDTree
let g:NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$'] "设置忽略文件类型
let g:NERDTreeWinSize=25 "窗口大小
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree")
    \ && b:NERDTree.isTabTree()) | q | endif " close tree if only tree left
nnoremap <F3> :NERDTreeToggle<CR>

" 缩进指示
Plug 'Yggdroot/indentLine'
let g:indentLine_char='⎸'
let g:indentLine_enabled = 1

" 不同颜色匹配括号
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" bottom-light curosr word
Plug 'itchyny/vim-cursorword'

" multi color search word
Plug 'lfv89/vim-interestingwords'
nnoremap <silent> f<CR> :call InterestingWords('n')<CR>
vnoremap <silent> f<CR> :call InterestingWords('v')<CR>
vnoremap <silent> <CR> :call InterestingWords('v')<CR>
nnoremap <silent> c<CR> :call UncolorAllWords()<CR>
nnoremap <silent> n :call WordNavigation('forward')<CR>
nnoremap <silent> N :call WordNavigation('backward')<CR>

" mark label, m*, mn, mN
Plug 'kshenoy/vim-signature'
nmap mn ]'
nmap mN ['

" markdown预览
Plug 'iamcco/markdown-preview.vim'
let g:mkdp_path_to_chrome='google-chrome'
let g:mkdp_auto_close=0
nmap <silent> <F7> <Plug>MarkdownPreview
nmap <silent> <F8> <Plug>StopMarkdownPreview

" (显示大纲)over view code
Plug 'majutsushi/tagbar'
nmap <Leader>t :TagbarToggle<CR>

" 查找工程文件
Plug 'mileszs/ack.vim'
let g:ackhighlight = 1
nnoremap <Leader>a :Ack!<Space>
vnoremap <Leader>a y<CR>:Ack! '<C-r>"'

" File, History, Buffer, ...
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_action = { 'left': 'split', 'right': 'vsplit' }
autocmd BufLeave term://*fzf/bin/fzf* q

" history file
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
nmap <Leader>f <C-p>

" Far, fast rext replace/find
Plug 'brooth/far.vim'
let g:far#window_layout = 'bottom'
let g:far#preview_window_layout = 'right'

" ranger
Plug 'francoiscabrol/ranger.vim'
Plug 'rbgrouleff/bclose.vim'  " dependence
let g:ranger_replace_netrw = 1  " open ranger when vim open a directory
let g:ranger_map_keys = 0
nnoremap <silent> <Leader>r :RangerCurrentDirectory<CR>
tnoremap <silent> <Esc><Leader>r <C-\><C-n>:RangerWorkingDirectory<CR>

" 对齐文本
Plug 'junegunn/vim-easy-align'
xmap ta <Plug>(EasyAlign)
nmap ta <Plug>(EasyAlign)<Space>

" 括号等字符处理
Plug 'tpope/vim-surround'

" multi corsors edit
Plug 'terryma/vim-multiple-cursors'

" 跳转到定义
Plug 'davidhalter/jedi-vim'
let g:jedi#completions_enabled = 0
let g:jedi#rename_command = ""

" 自动补全
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-ultisnips'
set completeopt=noinsert,menuone,noselect
autocmd BufEnter * call ncm2#enable_for_buffer()

" 常用补全
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" tab 补全
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

" 自动补全括号
Plug 'jiangmiao/auto-pairs'

" 批量注释 F4
Plug 'scrooloose/nerdcommenter'
let g:NERDCustomDelimiters = {'kivy': {'left': '# '}, 'prototxt': {'left': '# '} }
map <C-_> <Leader>ci<CR>
map <F4> <Leader>ci<CR>

" pep8 风格格式化代码
Plug 'Chiel92/vim-autoformat'
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
nnoremap <F6> :Autoformat<CR>

" send code to ipython to run
Plug 'jpalardy/vim-slime'
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_python_ipython = 1
xmap <Leader>ss <Plug>SlimeRegionSend
nmap <Leader>ss <Plug>SlimeParagraphSend
nmap <Leader>v  <Plug>SlimeConfig

call plug#end()


""""""""""""""""""""""SELF DEFINE"""""""""""""""""""""""
colorscheme molokai

" 切换行号显示
nnoremap <F2> :set nonu!<CR>:set relativenumber!<CR>

" quick leave quickfix
autocmd BufWinEnter * if &buftype=='quickfix' | nmap <buffer> q <A-q> | endif
autocmd BufLeave * if &buftype=='quickfix' | q | endif

" search selected word
func! SearchSelected()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    let @/ = join(lines, "\n")
endfunc
vnoremap <silent> * :call SearchSelected()<CR>nn
vnoremap <silent> # :call SearchSelected()<CR>N

" 空格翻页
nnoremap <Space> <C-f>
nnoremap <Backspace> <C-b>
vnoremap <Space> <C-f>
vnoremap <Backspace> <C-b>

" 滚动
nnoremap <Down> 4<C-e>
nnoremap <Up> 4<C-y>
nnoremap <Left> F<Space>h
nnoremap <Right> f<Space>l
nnoremap <Home> ^
nnoremap <End> $

" 前进<C-l>，后退<C-o>
nnoremap <C-l> <C-i>

" normal模式下Ctrl+c全选并复制到系统剪贴板(linux必须装有vim-gnome)
" visual模式下Ctrl+c复制、ctrl+x剪切选中内容到剪贴板
" Ctrl+v原样粘贴剪切板内容
nmap <C-c> gg"+yG
vmap <C-c> "+y
vmap <C-x> x:let @+=@"<CR>

inoremap <C-v> <ESC>"+pa

" w!!写入只读文件
cmap w!! w !sudo tee >/dev/null %:p

" 给当前单词添加引号
nnoremap '' viw<esc>a'<esc>hbi'<esc>lel
nnoremap "" viw<esc>a"<esc>hbi"<esc>lel
vnoremap '' c''<Esc>P
vnoremap "" c""<Esc>P

" 缩进文本
nnoremap > >>
nnoremap < <<
nnoremap <tab> >>
nnoremap <S-tab> <<
vnoremap > >gv
vnoremap < <gv
vnoremap <tab> >gv
vnoremap <S-tab> <gv

" Shift+y copy to end of current line
nnoremap Y y$

" upper, lower case recent text
nnoremap <Leader>u gu'[
nnoremap <Leader>U gU'[

autocmd FileType python nnoremap <buffer> dip Oimport ipdb; ipdb.set_trace()<C-[>

" emoji
inoremap <C-e> <C-X><C-U>

" 运行脚本
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
    return ''
endfunc

func! RunCpp()
    exec "!g++ % -o %<"
    exec "!time ./%<"
    ":cw
endfunc

func! RunPython()
    let vpy = search('python3', 'n') ? 3 : 2
    exec '!time python'.vpy.' %'
endfunc


"""""""""""""""""""""""""TERMINAL MODE""""""""""""""""""""
tnoremap <Esc> <C-\><C-n><C-w>
tnoremap <Esc><Esc> <C-\><C-n>

func! TermModeMap()
    " keymaps expecially ranger.vim is different in terminal-normal-mode
    set nonumber
    set norelativenumber
    nnoremap <buffer> q i
    nnoremap <buffer> <Esc>- <C-w>s:RangerWorkingDirectory<CR>
    nnoremap <buffer> <Esc>\ <C-w>v:RangerWorkingDirectory<CR>
    nnoremap <buffer> <Leader>r <C-\><C-n>:RangerWorkingDirectory<CR>
    startinsert
endfunc
autocmd BufEnter,TermOpen term://** call TermModeMap()

func! RangerMap()
    " press <Esc> before leave terminal-mode in ranger.vim
    tnoremap <buffer> <Esc> <Esc><C-\><C-n><C-w>
    tnoremap <buffer> <Esc><Esc> <Esc><C-\><C-n>
endfunc
autocmd BufEnter,TermOpen term://*ranger* call RangerMap()


"""""""""""""""""""""""""WINDOW MANAGER""""""""""""""""""""
func! s:ZoomToggle() abort
    " Zoom / Restore window.
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunc
command! ZoomToggle call s:ZoomToggle()

" window mode
nnoremap <Esc> <C-w>

" window close
nnoremap <silent> <A-q> :q<CR>
tnoremap <silent> <A-q> <C-\><C-n>:q<CR>

" window maximum
nnoremap <silent> <Esc>z :ZoomToggle<CR>
tnoremap <silent> <Esc>z <C-\><C-n>:ZoomToggle<CR>

" window split/vsplit
nnoremap <silent> <Esc>s <C-w>s:terminal<CR>
nnoremap <silent> <Esc>v <C-w>v:terminal<CR>
nnoremap <silent> <Esc>- <C-w>s:RangerCurrentDirectory<CR>
nnoremap <silent> <Esc>\| <C-w>v:RangerCurrentDirectory<CR>
tnoremap <silent> <Esc>s <C-\><C-n><C-w>s:terminal<CR>
tnoremap <silent> <Esc>v <C-\><C-n><C-w>v:terminal<CR>
tnoremap <silent> <Esc>- <C-\><C-n><C-w>s:RangerWorkingDirectory<CR>
tnoremap <silent> <Esc>\| <C-\><C-n><C-w>v:RangerWorkingDirectory<CR>

" window resize
nnoremap <C-Left>  <C-w>3<
nnoremap <C-Right> <C-w>3>
nnoremap <C-Down>  <C-w>3-
nnoremap <C-Up>    <C-w>3+
tnoremap <C-Left>  <C-\><C-n><C-w>3<
tnoremap <C-Right> <C-\><C-n><C-w>3>
tnoremap <C-Down>  <C-\><C-n><C-w>3-
tnoremap <C-Up>    <C-\><C-n><C-w>3+


"""""""""""""""""""""""""TAB MANAGER""""""""""""""""""""
" tab new
nnoremap <silent> <Esc>c :tabnew +terminal<CR>
tnoremap <silent> <Esc>c <C-\><C-n>:tabnew +terminal<CR>

" tab navigation
nnoremap <silent> <Esc>n :tabnext<CR>
nnoremap <silent> <Esc>N :tabprevious<CR>
nnoremap <silent> <Esc>p :tabprevious<CR>
tnoremap <silent> <Esc>n <C-\><C-n>:tabnext<CR>
tnoremap <silent> <Esc>N <C-\><C-n>:tabprevious<CR>
tnoremap <silent> <Esc>p <C-\><C-n>:tabprevious<CR>

" tab navigation with number
nnoremap <silent> <Esc>0 :tablast<cr>
tnoremap <silent> <Esc>0 <C-\><C-n>:tablast<cr>
for i in range(1, 9)
    execute "nnoremap <Esc>" . i . " " . i . "gt"
    execute "tnoremap <Esc>" . i . " <C-\\><C-n>" . i . "gt"
endfor

" Go to last active tab
autocmd TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <Esc>b :exe "tabn ".g:lasttab<cr>
tnoremap <silent> <Esc>b <C-\><C-n>:exe "tabn ".g:lasttab<cr>