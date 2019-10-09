set nocompatible              " be iMproved, required

" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif
" Load vim-plug for nvim
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

Plug 'altercation/vim-colors-solarized'
" Plug 'Yggdroot/indentLine'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'mattn/emmet-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
" Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

set laststatus=2

set number
set relativenumber
set autoindent

set hidden

set wrap
set linebreak
set nolist

set colorcolumn=80

set tabstop=4
set shiftwidth=4
set expandtab

set background=dark
silent! colorscheme solarized
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

" ag and fzf
nmap <leader>a :Ag 
nmap <leader>f :Files<cr>
nmap ; :Buffers<cr>

" visual selection pipe to some command
vmap \| ::w !

set conceallevel=2
let g:vim_markdown_folding_disabled = 1

set mouse=""
