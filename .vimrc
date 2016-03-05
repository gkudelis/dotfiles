execute pathogen#infect()

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
"set t_Co=256

set wildmode=longest,list,full
set wildmenu

set winaltkeys=no
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b

set grepprg=grep\ -nH\ $*

filetype plugin indent on

" NERDtree mapping
nmap <leader>n :NERDTree<cr>

" visual selection pipe to some command
vmap \| ::w !
