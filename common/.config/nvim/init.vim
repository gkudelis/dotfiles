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
Plug 'tpope/vim-eunuch'
Plug 'dkarter/bullets.vim'
"Plug 'sheerun/vim-polyglot'
"Plug 'scrooloose/syntastic'

" great for clojure
"Plug 'tpope/vim-classpath'
"Plug 'tpope/vim-fireplace'
"Plug 'guns/vim-sexp'
"Plug 'tpope/vim-sexp-mappings-for-regular-people'

" better grepping and finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" autocompletion
Plug 'roxma/nvim-yarp'
Plug 'Shougo/deoplete.nvim'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

Plug 'lambdalisue/suda.vim'

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
nmap <leader>no :NERDTree<cr>
nmap <leader>nt :NERDTreeFind<cr>

" git fugitive stuff
nmap <leader>gb :Gblame<cr>
nmap <leader>gs :G<cr>

" ag and fzf
nmap <leader>a :Ag 
nmap <leader>f :Files<cr>
nmap ; :Buffers<cr>
vmap <leader>a y:Ag <C-R>"<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}

" visual selection pipe to some command
vmap \| ::w !

set conceallevel=2
let g:vim_markdown_folding_disabled = 1

set mouse=""
set clipboard^=unnamed,unnamedplus

" python
----- nvim_python

" language server commands
nmap <leader>lm <Plug>(lcn-menu)
nmap <leader>ld <Plug>(lcn-definition)
nmap <leader>lh <Plug>(lcn-hover)
nmap <leader>le <Plug>(lcn-explain-error)

" autocompletion setup
let g:deoplete#enable_at_startup = 1

" snippet expansion and navigation
let g:UltiSnipsJumpForwardTrigger = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
set runtimepath+=~/.config/nvim/ged-snippets/

" language server commands
let g:LanguageClient_hasSnippetSupport = 1
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

" operations to help with zettel
nmap <leader>cy :let @+=expand('%:t')<CR>
nmap <leader>za :Ag <C-R>=expand('%:t')<CR><CR>
nmap <leader>zn :e <C-R>=strftime("~/zettel/%Y-%m-%d-%H%M%S.md")<CR><CR>

" 2 space indentation for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let g:suda_smart_edit = 1
