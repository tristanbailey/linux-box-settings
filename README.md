vim-settings
============

my starting vim settings


>>>>>


syntax on
filetype on
set bg=dark

" tags--------------------
" :InlineEdit " pull out part

" :TagbarOpen " code folded

" :TlistToggle " var and functions
" :tag getUser => Jump to getUser method
" :tn (or tnext) => go to next search result
" :tp (or tprev) => to to previous search result
" :ts (or tselect) => List the current tags

" cs" " surround text
" ds" " delete surround
" cst<div>
" dst

" indent
set cindent
set smartindent
set autoindent

" tabs
set expandtab
set shiftwidth=2
set tabstop=4
set showmatch " Show matching brackets.

" auto complete + C-n
set showcmd " Show (partial) command in status line.

" case search
set ignorecase " search ingore case if all lower search
set smartcase " Do smart case matching (flips igonore if use any caps)
set incsearch " search as type

" highlight search
set hlsearch " highlight all searches " :nohlsearch

"set visualbell
"set cinkeys=0{,0},:,0#,!,!^F
set cinkeys=0{,0},:,0#
set cinwords=if,else,while,do,for,switch,case   " Which keywords should indent
imap <C-e> <esc>$a
imap <C-l> <esc>g_
:nmap <C-n> :tabnext<cr>
" Press Space to turn off highlighting and clear any message already displayed.
:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" Press F4 to toggle highlighting on/off, and show current value.
:noremap <F4> :set hlsearch! hlsearch?<CR>

"off indent
nnoremap <silent> <F10> :set noautoindent<CR>

"" taglist settings
" Press F8 toggle tag list
nnoremap <silent> <F8> :TlistToggle<CR>
map <F9> :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
let Tlist_Close_On_Select=1
let Tlist_Exit_OnlyWindow=1
set title titlestring=%<%f\ %([%{Tlist_Get_Tagname_By_Line()}]%)

"vimdiff
set diffopt+=iwhite




>>>>>>>>>>>>>>>>>>>>>>>>>>>>
.bashrc

# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
 PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
 umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS'
 alias ll='ls $LS_OPTIONS -l'
 alias l='ls $LS_OPTIONS -lAh'
#
# Some more alias to avoid making mistakes:
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

 alias grep='grep --colour=always'

alias gpull='git pull; git status; git diff | more'
alias gvd='git difftool -t vimdiff'
alias vd='difftool -t vimdiff'

alias ack-grepp='ack-grep --php'

