set nocompatible              " be iMproved, required

" Load vim-plug for nvim
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

Plug 'altercation/vim-colors-solarized'
" Plug 'Yggdroot/indentLine'
" Plug 'jeetsukumaran/vim-buffergator'
Plug 'mattn/emmet-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

Plug 'roxma/vim-tmux-clipboard'

" nice multi-function plugins
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'

" great for clojure
"Plug 'tpope/vim-classpath'
"Plug 'tpope/vim-fireplace'
"Plug 'guns/vim-sexp'
"Plug 'tpope/vim-sexp-mappings-for-regular-people'

" better grepping and finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" autocompletion
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'aserebryakov/vim-todo-lists'

call plug#end()

set laststatus=2
set noshowmode

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
let g:lightline = { 'colorscheme': 'solarized' }

set wildmode=longest,list,full
set wildmenu

set winaltkeys=no
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b

" NERDtree mapping
nmap <leader>n :NERDTree<cr>

" git fugitive stuff
nmap <leader>gb :Gblame<cr>
nmap <leader>gs :G<cr>

" ag and fzf
nmap <leader>a :Ag 
nmap <leader>f :Files<cr>
nmap ; :Buffers<cr>
vmap a y:Ag <C-R>"<CR>

" visual selection pipe to some command
vmap \| ::w !

set conceallevel=2
let g:vim_markdown_folding_disabled = 1

set mouse=""
set clipboard^=unnamed,unnamedplus

" running rspec
----- nvim_rspec

" python
----- nvim_python

" language server commands
nmap <leader>d :call LanguageClient_textDocument_definition()<CR>
nmap <leader>h :call LanguageClient_textDocument_hover()<CR>

" autocompletion setup
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
let g:LanguageClient_serverCommands = {
----- nvim_lsp_servers
\ }

" syntactic setup
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
