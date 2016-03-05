set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'altercation/vim-colors-solarized'
Plugin 'Yggdroot/indentLine'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'mattn/emmet-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-classpath'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set rtp+=/Users/giedrius/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim
set laststatus=2

set nu
set autoindent

set hidden

set wrap
set linebreak
set nolist

set colorcolumn=80

set tabstop=4
set shiftwidth=4
set expandtab

syntax on
set background=dark
colorscheme solarized
"set cursorline
set t_Co=256

set wildmode=longest,list,full
set wildmenu

set winaltkeys=no
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b

set grepprg=grep\ -nH\ $*

" NERDtree mapping
nmap <leader>n :NERDTree<cr>

" visual selection pipe to some command
vmap \| ::w !
