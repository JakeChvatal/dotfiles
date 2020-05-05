" install vim-plug if it hasn't already been configured on this machine
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- Plugins ---
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'	" status bar
Plug 'tpope/vim-surround'       " close parens
Plug 'scrooloose/nerdtree'		" directory navigation
Plug 'junegunn/goyo.vim' 		" minimalist vim
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-fugitive'		" git
Plug 'wincent/command-t'		" fuzzy file finding
Plug 'justmao945/vim-clang'		" clang support for vim
Plug 'godlygeek/tabular'        " text alignment
Plug 'jceb/vim-orgmode'			" org mode support
Plug 'plasticboy/vim-markdown'  " markdown
" Plug 'rust-lang/rust.vim'     " rust for vim
" Plug 'fatih/vim-go'           " go for vim
call plug#end()


" --- Vim Settings ---
syntax on			" syntax highlighting
set expandtab		" expand tabs to spaces
set tabstop=4 		" tabs are 4 spaces
set shiftwidth=4 	" reindents are 4 spaces

filetype plugin indent on 	" indentation!

set clipboard=unnamedplus	" shared system clipboard
set number 					" line numbers
set relativenumber			" relative line numbers
set cursorline              " current line is visible
set showmatch               " show matching braces
set incsearch               " highlight as characters are entered
set hlsearch                " persistent highlight of prev search
set smartcase               " ignore case if search all lowercase
set lazyredraw              " only redraw components on change

syntax enable               " enable syntax highlighting

" remove backups
" TODO is this a good idea?
set nobackup
set nowritebackup
set noswapfile


" --- Key Mappings ---
let mapleader=" "                   " leader key is space
map <leader>t :NERDTreeToggle<CR>   " toggle nerdtree
map rr :source ~/.vimrc<CR>         " reload vim


" --- Event Listeners ---
" not sure what this does ...
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTee.isTabTree()) | q | endif

" remove trailing whitespace on save
" https://gitlab.com/kmidkiff/vim-configuration/-/blob/master/vimrc
autocmd BufWritePre * :%s/\s\+$//e

" smaller indentation for html, css
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal nofoldenable


" https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
" remap: option that makes mappings work recursively
" map: recursive mapping commands
" noremap: does not expand the next mapping
" nnoremap: normal mode
" vnoremap: visual mode
" o: operator-pending
" x: visual only
" s: select only
" i: insert mode only
" c: command line
" l: insert, command line, regexp search
"


