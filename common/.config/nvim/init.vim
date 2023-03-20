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

" --- structured editing for sexp
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-sexp'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" --- fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" --- LSP configuration
Plug 'neovim/nvim-lspconfig'

" --- autocompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" --- snippets
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'L3MON4D3/LuaSnip'

" --- interactive evaluation (REPL)
Plug 'bakpakin/fennel.vim'
Plug 'Olical/conjure', {'tag': 'v4.25.0'}

" --- key map suggestions
Plug 'liuchengxu/vim-which-key'

" vimwiki + zettel
Plug 'vimwiki/vimwiki'
Plug 'michal-h21/vim-zettel'
"Plug 'michal-h21/vimwiki-sync'

call plug#end()

" --- leaders
let mapleader = " "
let maplocalleader = ","
nnoremap <silent> <leader> :<c-u>WhichKey " "<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ","<CR>

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

" --- fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-y': {lines -> setreg('*', join(lines, "\n"))}}
nnoremap <leader>a :Ag 
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>
vnoremap <leader>a y:Ag <C-R>"<CR>

" --- snippets
" let g:UltiSnipsJumpForwardTrigger = "<c-f>"
" let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
" set runtimepath+=~/.config/nvim/ged-snippets/

" --- language client support
"let g:LanguageClient_hasSnippetSupport = 1
"let g:LanguageClient_serverCommands = {
"\ }
"nnoremap <leader>lm <Plug>(lcn-menu)
"nnoremap <leader>ld <Plug>(lcn-definition)
"nnoremap <leader>lh <Plug>(lcn-hover)
"nnoremap <leader>le <Plug>(lcn-explain-error)

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
set concealcursor=nc
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

" let g:vimwiki_list = [{'path': '~/zettel/', 'syntax': 'markdown', 'ext': '.md', 'auto_tags': 1}]
let g:vimwiki_list = [{'path': '~/zettel/', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:zettel_options = [{'front_matter': [['tags', ':stub: :inbox:']]}]
let g:zettel_format = "%Y-%m-%d-%H%M%S"
let g:zettel_date_format = "%Y-%m-%d"

" 2 space indentation for yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" --- LSP and autocomplete
" --- (see https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion)
lua << EOF

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local lspconfig = require('lspconfig')
local servers = { 'pylsp', 'solargraph', 'rust_analyzer', 'clojure_lsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   elseif luasnip.expand_or_jumpable() then
    --     luasnip.expand_or_jump()
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   elseif luasnip.jumpable(-1) then
    --     luasnip.jump(-1)
    --   else
    --     fallback()
    --   end
    -- end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

EOF
