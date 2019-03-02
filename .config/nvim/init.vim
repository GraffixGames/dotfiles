" init.vim by Noah Graff: ntgg.io

set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'rust-lang/rust.vim'
Plug 'tikhomirov/vim-glsl'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

call plug#end()

set hidden " Keep buffers in the background

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ }

" LSP
let g:LanguageClient_serverCommands = {
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
  \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" auto complete
autocmd FileType rust
\ call deoplete#custom#buffer_option('auto_complete', v:true)
let g:deoplete#enable_at_startup=1
call deoplete#custom#option('auto_complete', v:false)
let g:deoplete#sources#rust#racer_binary='which racer'
let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH.'/'
let g:deoplete#sources#rust#disable_keymap=1

let g:gruvbox_italic=1
color gruvbox

" GUI options:
set guifont='Fira\ Code:h10'
set guioptions-=m " removes the menu bar
set guioptions-=T " removes the toolbar
set guioptions-=r " removes the right hand scroll bar
set guioptions-=L " removes the left hand scroll bar

" TUI options:
set termguicolors

" General options:
set splitright
set splitbelow
set noshowmode " Mode showed in lightline
set wildmenu
set tabstop=4
set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set ruler
set list " Show Space, Tab, and EOL
set listchars=tab:▸\ ,eol:¬
set listchars +=space:·
set belloff=all " No annoying error sounds
" Indent options:
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab

let mapleader=","
nnoremap <leader>nt :NERDTreeToggle ./<CR>

" neovim integrated terminal options
tnoremap <Esc> <C-\><C-n>
" move between windows
nnoremap <leader>wh <C-W>h
nnoremap <leader>wl <C-W>l
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
" open a new split
nnoremap <leader>ws :vsplit<CR>
nnoremap <leader>wi :split<CR>
" move window to new tab
nnoremap <leader>wt <C-W><S-t>
" clear search
nnoremap <leader>/ :let @/=""<CR>

" buffer stuff:
" normal mode:
" (b)uffer (e)xplorer
nnoremap <leader>be :ls<CR>:b<Space>
" (b)uffer (p)revious
nnoremap <leader>bp :b#<CR>
" (b)uffer (t)erminal
" only works if a terminal as already open
nnoremap <leader>bt :b term<CR>

nnoremap Q @q

nnoremap <silent> <S-CR> :pu! _<CR>:']+1<CR>
nnoremap <silent> <CR> :pu _<CR>:'[-1<CR>
