"vundle settings-----------{{{
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-powerline'
Plugin 'wincent/Command-T'

Plugin 'Tagbar'
Plugin 'taglist.vim'
Plugin 'The-NERD-tree'
Plugin 'The-NERD-Commenter'
Plugin 'a.vim'
Plugin 'txt.vim'  
Plugin 'grep.vim' 
Plugin 'echofunc.vim'
"Plugin 'clang-complete'
Plugin 'CmdlineComplete'
"Plugin 'javacomplete'
"Plugin 'neocomplcache'
"Plugin 'OmniCppComplete'
Plugin 'DoxygenToolkit.vim'
Plugin 'fangxin327/YouCompleteMe'
Plugin 'Valloric/ListToggle'
Plugin 'scrooloose/syntastic'

call vundle#end()
filetype plugin indent on
"}}}

"Basic Settings------------------{{{
"
"color and display settings--{{{
colorscheme ron
set background=dark "背景使用黑色 
autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
syntax on           " 语法高亮  
set novisualbell    " 不要闪烁(不明白)  
set nu
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示
set scrolloff=3 	" 光标移动到buffer的顶部和底部时保持3行距离
set linespace=0
"}}}
"
"statusline configs------{{{
"set statusline=%f\ -\     " 文件的路径
"set statusline+=Type:%y
"set statusline+=%=        " 切换到右边
"set statusline+=%l/%L     " 显示行数
set laststatus=2   
set fillchars+=stl:\ ,stlnc:\
set report=0	       	" 通过使用: commands命令，告诉我们文件的哪一行被改变过
"}}}
"
"other settings----------------{{{
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
set magic               
set completeopt=longest,menu
set viminfo+=!		" 保存全局变量
set noswapfile
set foldenable      " 允许折叠  
set completeopt=preview,menu 		"代码补全 
set clipboard+=unnamed 			"共享剪贴板  
set history=1000
set mouse=a	" 可以在buffer的任何地方使用鼠标
set selection=exclusive
set selectmode=mouse,key
""}}}
" 
" file settings-------------{{{
set autoread
set autowrite
set confirm
set nobackup
set enc=utf-8 		"编码设置
set fencs=utf-8,gb18030,gbk,gb2312,cp936
filetype on	     " 侦测文件类型
filetype plugin on   " 载入文件类型插件
filetype indent on
""}}}
""
"search settings----------{{{
set showmatch     	" 高亮显示匹配的括号
set matchtime=1
set ignorecase          "搜索忽略大小写
set hlsearch            "搜索逐字符高亮
set incsearch
"}}}
"
" indent and tab configs{{{
set autoindent
set cindent
set shiftwidth=4
set noexpandtab
set smarttab
set backspace=2
""}}}
"
"}}}

""FileType-specific settings-----------{{{

""Vimscript file settings-----------{{{
augroup filetype_vim
    autocmd!
    autocmd filetype vim setlocal foldmethod=marker
    autocmd filetype vim :inoremap <buffer>  <leader>- -----------{{{<cr>"}}}<esc>O
    autocmd filetype vim :iunmap "
augroup end
"}}}
"
"c and cpp and java file settings-----------{{{
augroup filetype_cpp
    autocmd!

    autocmd FileType cpp,c,java :inoremap <buffer> { {<CR>}<ESC>O
    autocmd FileType cpp,c,java setlocal foldmethod=indent
    autocmd FileType c,cpp iabbrev <buffer> icl include<><left>
    autocmd FileType cpp,c,java iabbrev <buffer> iff if ()<esc>i 
    autocmd FileType cpp,c,java map <buffer> <leader><space> :w<cr>:make<cr>
augroup end

""}}}
"}}}

"map settings-----------{{{
let mapleader=","
"global imap settings -----------{{{
inoremap <c-u> <esc>viwUi
inoremap <c-d> <esc>ddko
inoremap <c-l> <right>
inoremap <c-j> <left>
inoremap <c-b> <end>;<c-m>
inoremap jk <esc> 
inoremap <c-[> <nop>
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i
""}}}
" global nmap settings-----------{{{
nnoremap <leader>w :wq<cr>
nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>ll <c-w>l
nnoremap <leader>k <c-w>k
nnoremap <leader>f :find<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>lv :source $MYVIMRC<cr>
nnoremap <leader>ma :make<cr>
nnoremap H 0
nnoremap L <end>
nnoremap J }
nnoremap K {
nnoremap <C-A> ggVGY
" "}}}
" global omap settings-----------{{{
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il{ :<c-u>normal! F}vi{<cr>
onoremap in} :<c-u>normal! f{vi{<cr>
" "}}}
" special function maps -----------{{{
map <F5> :call CompileRunGcc()<CR>
" function CompileRunGcc -----------{{{

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
	exec "!gcc % -o %<"
	exec "! ./%<"
    elseif &filetype == 'cpp'
	exec "!g++ % -o %< `pkg-config opencv --cflags --libs`"
	exec "! ./%<"
    elseif &filetype == 'java' 
	exec "!javac %" 
	exec "!java %<"
    elseif &filetype == 'sh'
	:!./%
    elseif &filetype == 'py'
	exec "!python %"
	exec "!python %<"
    endif
endfunc
" "}}}

" "}}}
""}}}

"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""function SetTitle() ----------------{{{
func! SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
	call setline(1,"\#########################################################################") 
	call append(line("."), "\# File Name: ".expand("%")) 
	call append(line(".")+1, "\# Author: FangXin") 
	call append(line(".")+2, "\# mail: fangxin327@126.com") 
	call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
	call append(line(".")+4, "\# Discribtion: ") 
	call append(line(".")+5, "\#########################################################################") 
	call append(line(".")+6, "\#!/bin/bash") 
	call append(line(".")+7, "") 
    else 
	call setline(1, "/*************************************************************************") 
	call append(line("."), "	> File Name: ".expand("%")) 
	call append(line(".")+1, "	> Author: FangXin") 
	call append(line(".")+2, "	> Mail:fangxin327@126.com ") 
	call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
	call append(line(".")+4, "	> Discribtion: ")
	call append(line(".")+5, " ************************************************************************/") 
	call append(line(".")+6, "")
    endif
    if &filetype == 'cpp'
	call append(line(".")+6, "#include<iostream>")
	call append(line(".")+7, "using namespace std;")
	call append(line(".")+8, "")
    endif
    if &filetype == 'c'
	call append(line(".")+6, "#include<stdio.h>")
	call append(line(".")+7, "")
    endif
    if &filetype == 'java'
	call append(line(".")+6,"public class ".expand("%"))
	call append(line(".")+7,"")
    endif
    autocmd BufNewFile * normal G
endfunc 
""}}}

"plugin settings-----------{{{

"powerline
set guifont=PowerlineSymbols\ for\ Powerline
set t_Co=256
let g:Powerline_symbols = 'fancy'

"OmniCppComplete
set tags+=~/.vim/tags/opencv
set tags+=~/.vim/tags/cpp
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview
nnoremap  <leader>uc :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"taglist
let Tlist_Show_One_File = 1            "只显示当前文件的taglist，默认是显示多个
let Tlist_Exit_OnlyWindow = 1          "如果taglist是最后一个窗口，则退出vim
let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist
let Tlist_GainFocus_On_ToggleOpen = 1  "打开taglist时，光标保留在taglist窗口
let Tlist_Ctags_Cmd='/usr/bin/ctags'  "设置ctags命令的位置
nnoremap <leader>tl : Tlist<CR>        
"设置关闭和打开taglist窗口的快捷键''

"tagbar
nnoremap <leader>tb :call tagbar#autoopen()<cr>
let g:tagbar_ctags_bin='/usr/bin/ctags'
let g:tagbar_width=30
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.java call tagbar#autoopen()

"nerdtree
nnoremap <leader>nt :NERDTree<cr>

"command-t
let g:CommandTMinHeight=5
let g:CommandTMaxHeight=5
"}}}
