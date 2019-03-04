" init.vim by Noah Graff: ntgg.io

set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'rust-lang/rust.vim'
Plug 'dag/vim-fish'
Plug 'tikhomirov/vim-glsl'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }

call plug#end()

filetype plugin indent on
syntax on

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
set hidden " Keep buffers in the background
set noshowmode " Mode showed in lightline
set wildmenu
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
set smarttab
set autoindent
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Custom commands
let mapleader=","

" neovim integrated terminal options
" needed for fzf to be able to close split on <Esc>
" I'm sure there is a better way to do this, but it works
function TerminalMapQuit()
    if b:term_title!~"#FZF"
        tnoremap <buffer> <Esc> <C-\><C-n>
    endif
endfunction

augroup terminal_mapping
    autocmd!
    autocmd TermOpen * call TerminalMapQuit()
augroup end

tnoremap <C-\><Esc> <Esc>

" move between windows
nnoremap <leader>wh <C-W>h
nnoremap <leader>wl <C-W>l
nnoremap <leader>wj <C-W>j
nnoremap <leader>wk <C-W>k
" open a new split
nnoremap <leader>ws :vsplit<CR>
nnoremap <leader>wi :split<CR>
" clear search
nnoremap <leader>/ :let @/=""<CR>

" buffer stuff:
" normal mode:
" (b)uffer (e)xplorer
nnoremap <leader>be :Buffers<CR>
" (b)uffer (p)revious
nnoremap <leader>bp :b#<CR>
" (b)uffer (t)erminal
" works iff one terminal is open
nnoremap <leader>bt :b term<CR>

" FZF stuff:
function FindFilesFZF()
    if system("git rev-parse --is-inside-work-tree") =~ "true"
        :GFiles
    else
        :Files
    endif
endfunction

nnoremap <leader>ff :call FindFilesFZF()<CR>
nnoremap <leader>faf :Files<CR>
nnoremap <leader>fg :Rg<CR>

nnoremap Q @q

nnoremap <silent> <S-CR> :pu! _<CR>:']+1<CR>
nnoremap <silent> <CR> :pu _<CR>:'[-1<CR>

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ }

" LSP
let g:LanguageClient_serverCommands = {
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
  \ }

" from fzf help page
let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', 'Normal'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" auto complete
augroup filetype_rust
    autocmd!
    autocmd FileType rust
    \ call deoplete#custom#buffer_option('auto_complete', v:true)
augroup end

let g:deoplete#enable_at_startup=1
call deoplete#custom#option('auto_complete', v:false)
let g:deoplete#sources#rust#racer_binary='which racer'
let g:deoplete#sources#rust#rust_source_path=$RUST_SRC_PATH.'/'
let g:deoplete#sources#rust#disable_keymap=1
