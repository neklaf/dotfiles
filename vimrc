" http://gergap.wordpress.com/2009/05/29/minimal-vimrc-for-cc-developers/
" disable vi compatibility (emulation of old bugs)
set nocompatible " be iMproved, required by bundle
filetype off " required by vundle

"""""" VUNDLE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Bundle 'gmarik/Vundle.vim'

" My plugins 
" original repos on github
Bundle 'kien/ctrlp.vim'
" Bundle 'majutsushi/tagbar'

" vim-scripts repos
Bundle 'a.vim'
Bundle 'ack.vim'
" Bundle 'wombat256.vim'

call vundle#end()         " required
filetype plugin indent on " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""" INDENTATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 100 chars. 80 is somewaht antiquated with nowadays displays.
" set textwidth=100

""""" SEARCH RESULT HIGHLIGHT
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hls
" Set a shortcut to mute highlight until next search (Practical Vim, tip 80)
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

"""""" SEARCH WITH ACK
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set grepprg=ack-grep\ --ignore-file=is:tags\ --ignore-dir=Release\ --ignore-dir=Debug\ --no-group\ --column\ $*
set grepformat=%f:%l:%c:%m

"""""" ENCODING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" output encoding shown in the terminal latin1 (used in most projects)
"set encoding=latin1
" output encoding of the file that is written
set fileencoding=latin1

"""""" KEY MAPPING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To enable/disable paste (allows to paste into vim buffer avoding autotabs).
set pastetoggle=<F2>

nnoremap <f5> :!ctags -R --exclude=.git --exclude=CVS --languages=c++,c --c++-kinds=+p --fields=+iaS --extra=+q<CR>

"""""" TAGBAR
"nmap <F8> :TagbarToggle<CR>

"""""" CTRL-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/Debug*,*/Release*

"""""" PYTHON
autocmd FileType python set omnifunc=pythoncomplete#Complete

"""""" OTHERS
if has("statusline")
    set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" Line numbers
set number

"""""" SYNTAX HIGHLIGHT 
"""""  (color schemes managed with vundle must be loaded after Bundle '')
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn syntax highlighting on
set t_Co=256
syntax on
" on installation of my dotfiles this scheme does not exist, avoid error msg!
silent! colorscheme wombat256mod
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

