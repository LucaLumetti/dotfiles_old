set nocompatible
filetype off

let mapleader = ","

set hidden
set splitbelow splitright
set scrolloff=8

" Folds
set foldenable
set foldlevelstart=99
set foldnestmax=20
set foldmethod=indent

" Plugin
call plug#begin('~/.config/nvim/plugged')
Plug 'VundleVim/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'mbbill/undotree'
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
" Plug 'sheerun/vim-polyglot'
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'
" Plug 'nvim-lua/completion-nvim'
" Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'wikitopian/hardmode'
" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'
Plug 'nvim-telescope/telescope.nvim'
Plug 'davidhalter/jedi'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

filetype plugin indent on

" Autocompleter + lsp
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact']

" lua << EOF
" -- LSP settings
" local nvim_lsp = require('lspconfig')
" vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

" local servers = { 'pyls', 'clangd' }

" for _, lsp in ipairs(servers) do
"   -- nvim_lsp[lsp].setup { on_attach = require'completion'.on_attach }
"   nvim_lsp[lsp].setup { on_attach = require'completion'.on_attach, cmd = { "pyls" } }
" end
" EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
autocmd CursorHold * silent call CocActionAsync('highlight')

nnoremap gd :lua vim.lsp.buf.definition()<CR>


" Airline
set laststatus=2
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Backspace
set bs=2

" Show whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color Scheme
set t_Co=256
let g:airline_theme = 'spaceduck'
" let g:airline_theme='gruvbox_material'
" let g:gruvbox_material_background='hard'
" let g:gruvbox_material_palette='material'
" colorscheme gruvbox-material
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
colorscheme spaceduck

highlight CursorLine ctermfg=none ctermbg=234 cterm=none

let g:gruvbox_invert_selection='0'
let g:airline_powerline_fonts = 1
set cursorline

" Line numbers and length
set number
highlight LineNr ctermfg=gray
highlight CursorLineNr ctermfg=yellow cterm=bold
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set relativenumber nu
set wrap
set tw=80
set signcolumn=yes
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey
" set showbreak=+++

" Tab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smartindent
set smartcase

" Misc
set wildmenu
set lazyredraw

" Search
set incsearch
set hlsearch

" ctags
command! MakeTags !ctags -R .

" ctrlp
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.(git|hg|svn|node_modules)|\_site)$',
      \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
      \}
let g:ctrlp_working_path_mode = 'r'


" Disable hjkl
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
let g:HardMode_level = 'wannabe'

" Global movs
nnoremap j gj
nnoremap k gk

" Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-r>l :vertical resize +2<CR>
nnoremap <C-r>h :vertical resize -2<CR>
nnoremap <C-r>j :resize +2<CR>
nnoremap <C-r>k :resize -2<CR>
nnoremap <C-S-h> <C-w>t<C-w>H
nnoremap <C-S-k> <C-w>t<C-w>K
nnoremap <leader>tt <C-w>v:terminal<CR>

" make
nnoremap <F5> :make %<<CR>

" Buffers
nnoremap <C-t> :edit<space>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bq :bp <BAR> bd #<CR>
nnoremap <leader>bl :ls<CR>

" Search, remove highlight
map <silent> <C-n> :nohl<CR>
