                                  " --- Plugins ---
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'    " status bar
Plug 'tpope/vim-surround'         " close parens
Plug 'scrooloose/nerdtree'        " directory navigation
Plug 'junegunn/goyo.vim'          " minimalist vim
Plug 'junegunn/limelight.vim'
Plug 'wincent/command-t'          " fuzzy file finding
Plug 'godlygeek/tabular'          " text alignment
Plug 'jceb/vim-orgmode'           " org mode support
Plug 'plasticboy/vim-markdown'    " markdown
Plug 'joshdick/onedark.vim'       " one dark theme for vim
                                  " Plug 'rust-lang/rust.vim'           " rust for vim
                                  " Plug 'fatih/vim-go'                 " go for vim
call plug#end()

                                  " --- Vim Settings ---
syntax on                         " syntax highlighting
colorscheme onedark               " one dark colors
set expandtab                     " expand tabs to spaces
set tabstop=4                     " tabs are 4 spaces
set shiftwidth=4                  " reindents are 4 spaces

filetype plugin indent on         " indentation!

set clipboard=unnamedplus         " shared system clipboard
set number                        " line numbers
set relativenumber                " relative line numbers
set cursorline                    " current line is visible
set showmatch                     " show matching braces
set incsearch                     " highlight as characters are entered
set hlsearch                      " persistent highlight of prev search
set smartcase                     " ignore case if search all lowercase
set lazyredraw                    " only redraw components on change

syntax enable                     " enable syntax highlighting


" from https://github.com/joshdick/onedark.vim
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" remove backups
" TODO is this a good idea?
set nobackup
set nowritebackup
set noswapfile

let g:limelight_conceal_ctermfg = 'Gray'


" --- Key Mappings ---
" leader key is space
let mapleader=" "

" toggle nerdtree
map <leader>t      : NERDTreeToggle<CR>
" enter focus mode
map <leader>f      : Goyo<CR>
" start tabularize
map <leader>d      : Tabularize /
" reload vim
map <leader>rr     : source ~/.vimrc<CR>

" travel by visible lines
map j gj
map k gk

" --- Event Listeners ---
" not sure what this does ...
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTee.isTabTree()) | q | endif

" Goyo triggers focus mode
autocmd! User GoyoEnter Limelight  | set cursorline!
autocmd! User GoyoLeave Limelight! | set cursorline

" remove trailing whitespace on save
" https://gitlab.com/kmidkiff/vim-configuration/-/blob/master/vimrc
autocmd BufWritePre * :%s/\s\+$//e

" smaller indentation for html, css
autocmd FileType css    setlocal shiftwidth=2 tabstop=2
autocmd FileType html   setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal nofoldenable
