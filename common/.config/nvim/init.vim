set nocompatible              " be iMproved, required

" Load vim-plug for nvim
if empty(glob("~/.local/share/nvim/site/autoload/plug.vim"))
    execute '!curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin()

" --- defaults
Plug 'tpope/vim-sensible'

" --- fennel configuration
Plug 'Olical/aniseed', { 'tag': 'v3.23.0' }

" --- display
Plug 'altercation/vim-colors-solarized'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'

" --- filesystem
Plug 'scrooloose/nerdtree'
Plug 'lambdalisue/suda.vim'
"Plug 'tpope/vim-eunuch'

" --- git
Plug 'tpope/vim-fugitive'

" --- stuff - may want to remove maybe?
"Plug 'dkarter/bullets.vim'
"Plug 'plasticboy/vim-markdown'
"Plug 'mattn/emmet-vim'
"Plug 'sheerun/vim-polyglot'
"Plug 'scrooloose/syntastic'

" --- structured editing for sexp
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" --- fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" --- autocompletion
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" --- LSP client
Plug 'neovim/nvim-lspconfig'
"Plug 'autozimu/LanguageClient-neovim', {
"  \ 'branch': 'next',
"  \ 'do': 'bash install.sh',
"  \ }

" --- interactive evaluation (REPL)
Plug 'bakpakin/fennel.vim'
Plug 'Olical/conjure', {'tag': 'v4.25.0'}

" vimwiki + zettel
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'
Plug 'michal-h21/vimwiki-sync'

call plug#end()

" --- leaders
let mapleader = "\\"
let maplocalleader = ","

" --- display
"set t_Co=256
let g:lightline = { 'colorscheme': 'solarized' }

" --- filesystem
nnoremap <leader>no :NERDTree<cr>
nnoremap <leader>nt :NERDTreeFind<cr>
let g:suda_smart_edit = 1

" --- git
nnoremap <leader>g :G<cr>
nnoremap <leader>gb :G blame<cr>
nnoremap <leader>gp :G push<cr>

" --- stuff
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" --- fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}
nnoremap <leader>a :Ag 
nnoremap <leader>f :Files<cr>
nnoremap ; :Buffers<cr>
vnoremap <leader>a y:Ag <C-R>"<CR>

" --- snippets
let g:UltiSnipsJumpForwardTrigger = "<c-f>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
set runtimepath+=~/.config/nvim/ged-snippets/

" --- autocompletion
let g:deoplete#enable_at_startup = 1

" --- language client support
"let g:LanguageClient_hasSnippetSupport = 1
"let g:LanguageClient_serverCommands = {
"\ }
"nnoremap <leader>lm <Plug>(lcn-menu)
"nnoremap <leader>ld <Plug>(lcn-definition)
"nnoremap <leader>lh <Plug>(lcn-hover)
"nnoremap <leader>le <Plug>(lcn-explain-error)

" --- LSP client
lua << EOF
require'lspconfig'.pylsp.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.clojure_lsp.setup{}
EOF

set background=dark
colorscheme solarized

set noshowmode
set number
set relativenumber
set hidden
set wrap
set linebreak
set nolist

set colorcolumn=80
"set cursorline

set tabstop=4
set shiftwidth=4
set expandtab

set wildmode=longest,list,full

set winaltkeys=no
set guioptions-=m
set guioptions-=T
set guioptions-=l
set guioptions-=r
set guioptions-=b

" visual selection pipe to some command
vnoremap \| ::w !

set conceallevel=2
let g:vim_markdown_folding_disabled = 1

set mouse=""
set clipboard^=unnamed,unnamedplus

" python
----- nvim_python

" operations to help with zettel
"nnoremap <leader>cy :let @+=expand('%:t')<CR>
"nnoremap <leader>za :Ag <C-R>=expand('%:t')<CR><CR>
nnoremap <leader>zn :ZettelNew 
nnoremap <leader>zb :ZettelBackLinks<CR>
nnoremap <leader>zt :VimwikiSearchTags 
nnoremap <leader>zi :VimwikiSearchTags unlinked<CR>:lopen<CR>
nnoremap <leader>zs :VimwikiSearchTags stub<CR>:lopen<CR>

let g:vimwiki_list = [{'path': '~/zettel/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]
let g:vimwiki_markdown_link_ext = 1
let g:zettel_options = [{'front_matter': [['tags', ':stub: :unlinked:']]}]
let g:zettel_format = "%Y-%m-%d-%H%M%S"
let g:zettel_date_format = "%Y-%m-%d"

" 2 space indentation for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
