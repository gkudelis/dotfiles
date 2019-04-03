set nocompatible              " be iMproved, required

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'
" Plug 'Yggdroot/indentLine'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'mattn/emmet-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
Plug 'powerline/powerline'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fireplace'
Plug 'scrooloose/syntastic'

" nice multi-function plugins
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'

" great for clojure
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" better grepping and finding
Plug 'mileszs/ack.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" autocompletion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

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

syntax on
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

" visual selection pipe to some command
vmap \| ::w !

set conceallevel=2
let g:vim_markdown_folding_disabled = 1

set clipboard=unnamed

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" shortcuts for ag and fzf
nmap <Leader>a :Ack!<Space>
nmap ; :Buffers<CR>
nmap <Leader>f :Files<CR>

" autocompletion setup
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

" syntactic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
