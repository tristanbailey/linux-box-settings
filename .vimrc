" File: _vimrc             
" Version: 1
" Author: Tristan Bailey (Based on Seth Mason)
" Created: 19 Nov 2012 10:20:19
" Last-modified: 31 Jul 2013 10:21:44
" All my Vim commands for the taking


" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" Turn on the verboseness to see everything vim is doing.
"set verbose=9

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" I like 4 spaces for indenting
set shiftwidth=4

" I like 4 stops
set tabstop=4

" Spaces instead of tabs
"set expandtab

" Always  set auto indenting on
set autoindent
"setlocal noautoindent
"setlocal nocindent
"setlocal nosmartindent
"setlocal indentexpr=
"Here is a mapping so you can press F7 to disable auto indenting:
nnoremap <F7> :setl noai nocin nosi inde=<CR>

" togget :set paste for non indented text
set pastetoggle=<F10>

" select when using the mouse
set selectmode=mouse


" do not keep a backup files 
set nobackup
set nowritebackup

if has('gui_running')
    " i like about 80 character width lines
    set textwidth=78
    " Set 52 lines for the display
    set lines=52
    " 2 for the status line.
    set cmdheight=2
    " add columns for the Project plugin
    set columns=110
    " enable use of mouse
    set mouse=a
    " for the TOhtml command
    let html_use_css=1
endif

" keep 50 lines of command line history
set history=50  

" show the cursor position all the time
set ruler       

" show (partial) commands
set showcmd     

" do incremental searches (annoying but handy);
set incsearch 

" Show  tab characters. Visual Whitespace.
"set list
"set listchars=tab:>.,trail:.

" Set ignorecase on
set ignorecase

" smart search (override 'ic' when pattern has uppers)
set scs

" Set 'g' substitute flag on
" set gdefault

" Set status line
set statusline=[%02n]\ %f\ %(\[%M%R%H]%)%=\ %4l,%02c%2V\ %P%*

" Always display a status line at the bottom of the window
set laststatus=2

" Set vim to use 'short messages'.
" set shortmess=a

" Insert two spaces after a period with every joining of lines.
" I like this as it makes reading texts easier (for me, at least).
"set joinspaces

" showmatch: Show the matching bracket for the last ')'?
set showmatch

" allow tilde (~) to act as an operator -- ~w, etc.
set notildeop


" highlight strings inside C comments
let c_comment_strings=1

" Commands for :Explore
let g:explVertical=1    " open vertical split winow
let g:explSplitRight=1  " Put new window to the right of the explorer
let g:explStartRight=0  " new windows go to right of explorer window


if has("gui")
  " set the gui options to:
  "   g: grey inactive menu items
  "   m: display menu bar
  "   r: display scrollbar on right side of window
  "   b: display scrollbar at bottom of window
  "   t: enable tearoff menus on Win32
  "   T: enable toolbar on Win32
  set go=gmr
  set guifont=Courier
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" ************************************************************************
" C O M M A N D S
"

"switch to directory of current file
command! CD cd %:p:h

" ************************************************************************
" K E Y   M A P P I N G S
"
map <Leader>e :Explore<cr>
map <Leader>s :Sexplore<cr> 

" pressing < or > will let you indent/unident selected lines
vnoremap < <gv
vnoremap > >gv

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Make tab in v mode work like I think it should (keep highlighting):
vmap <tab> >gv
vmap <s-tab> <gv

" map ,L mz1G/Last modified:/e<Cr>CYDATETIME<Esc>`z
map ,L    :let @z=TimeStamp()<Cr>"zpa
map ,datetime :let @z=strftime("%d %b %Y %X")<Cr>"zpa
map ,date :let @z=strftime("%d %b %Y")<Cr>"zpa

" Map <c-s> to write current buffer.
map <C-s> :w<cr>
imap <C-s> <C-o><C-s>
imap <C-s> <esc><C-s>

" Buffer naviation
map <M-Left> :bprevious<CR>
map <M-Right> :bnext<CR>


" Select all.
map <c-a> ggVG

" Undo in insert mode.
imap <c-z> <c-o>u

" Load my color scheme 
"colorscheme slack



" insert mode
imap <C-b> <Left>
imap <C-f> <Right>
"imap <C-a> <C-o>:call <SID>home()<CR>
imap <C-a> <Home>
imap <C-e> <End>
imap <M-b> <C-o>b
imap <M-f> <C-o>e<Right>
imap <C-d> <Del>
imap <C-h> <BS>
imap <M-d> <C-o>de
imap <M-h> <C-w>
imap <C-k> <C-r>=<SID>kill_line()<CR>

" command line mode
cmap <C-p> <Up>
cmap <C-n> <Down>
cmap <C-b> <Left>
cmap <C-f> <Right>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <M-b> <S-Left>
cmap <M-f> <S-Right>


" ************************************************************************
" B E G I N  A U T O C O M M A N D S
"
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Normally don't automatically format 'text' as it is typed, only do this
  " with comments, at 79 characters.
"  au BufNewFile,BufEnter *.c,*.h,*.java,*.jsp set formatoptions-=t tw=79

  " add an autocommand to update an existing time stamp when writing the file 
  " It uses the functions above to replace the time stamp and restores cursor 
  " position afterwards (this is from the FAQ) 
 "  autocmd BufWritePre,FileWritePre *   ks|call UpdateTimeStamp()|'s


endif " has("autocmd")

" GUI ONLY type stuff.
if has("gui")
  :menu &MyVim.Current\ File.Convert\ Format.To\ Dos :set fileformat=dos<cr> :w<cr>
  :menu &MyVim.Current\ File.Convert\ Format.To\ Unix :set fileformat=unix<cr> :w<cr>
  :menu &MyVim.Current\ File.Remove\ Trailing\ Spaces\ and\ Tabs :%s/[  ]*$//g<cr>
  :menu &MyVim.Current\ File.Remove\ Ctrl-M :%s/^M//g<cr>
  :menu &MyVim.Current\ File.Remove\ All\ Tabs :retab<cr>
  :menu &MyVim.Current\ File.To\ HTML :runtime! syntax/2html.vim<cr>
  " these don't work for some reason
  ":amenu &MyVim.Insert.Date<Tab>,date <Esc><Esc>:,date<Cr>
  ":amenu &MyVim.Insert.Date\ &Time<Tab>,datetime <Esc><Esc>:let @z=YDATETIME<Cr>"zpa
  :amenu &MyVim.Insert.Last\ &Modified<Tab>,L <Esc><Esc>:let @z=TimeStamp()<CR>"zpa
  :amenu &MyVim.-SEP1- <nul>
  :amenu &MyVim.&Global\ Settings.Toggle\ Display\ Unprintables<Tab>:set\ list!	:set list!<CR>
  :amenu &MyVim.-SEP2- <nul>
  :amenu &MyVim.&Project :Project<CR>

  " hide the mouse when characters are typed
  set mousehide
endif

" ************************************************************************
" A B B R E V I A T I O N S 
"
abbr #b /************************************************************************
abbr #e  ************************************************************************/

nore ; :
nore , ;

hi Cus guibg=Brown
hi Cus1 guibg=Brown
match Cus ' \+$'
match Cus1 '\t\+$'

"au BufRead,BufNewFile * syn match sql /"\zs \+\ze"/
"au BufRead,BufNewFile * hi sql guifg=white guibg=red ctermfg=white ctermbg=red

" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set scrolloff=5                 " keep at least 5 lines around the cursori

