" Install vim-plug if not already installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent :PlugInstall
endif

" NOTE: A TODO with no comment corresponds to an item that is currently being tried,
"       and may be removed in the future.

" --- Plugins ---
call plug#begin('~/.vim/plugged')
" editing
Plug 'tpope/vim-surround'         " close parens
Plug 'mbbill/undotree'            " undo tree
Plug 'wincent/terminus'           " better terminal integration
Plug 'farmergreg/vim-lastplace'   " save place in file
Plug 'junegunn/vim-easy-align'    " align text
Plug 'matze/vim-move'             " move lines without cut-paste TODO
Plug 'tomtom/tcomment_vim'        " autocomment support TODO make use of this!
Plug 'tpope/vim-repeat'           " improves repeats TODO
Plug 'wellle/targets.vim'         " better targeting text for operating inside TODO make use of this!
Plug 'svermeulen/vim-yoink'       " cycle between pastes when pasting
Plug 'dense-analysis/ale'         " linting
Plug 'tpope/vim-unimpaired'       " bracket mapping

" navigation
Plug 'scrooloose/nerdtree'        " directory navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finding - incredible!
Plug 'junegunn/fzf.vim'
Plug 'yangmillstheory/vim-snipe' " quick navigation ! TODO bind

" appearance
Plug 'vim-airline/vim-airline'    " status bar
Plug 'junegunn/goyo.vim'          " minimalist vim
Plug 'junegunn/limelight.vim'     " highlight current paragraph
Plug 'joshdick/onedark.vim'       " one dark theme for vim
Plug 'camspiers/lens.vim'         " auto window resizing TODO do i really ever need this?
Plug 'vim-scripts/folddigest.vim' " displays folds as summary

" git TODO
Plug 'airblade/vim-gitgutter'     " displays git diff info
Plug 'tpope/vim-fugitive'         " vim convenience functions
Plug 'rbong/vim-flog'             " vim branch viewer

" tools
Plug 'kassio/neoterm'               " repl in vim TODO
Plug 'tpope/vim-eunuch'             " TODO shell commands - see if these are used

" specific file type support
Plug 'sheerun/vim-polyglot'         " syntax highlighting
Plug 'jceb/vim-orgmode'
Plug 'reedes/vim-pencil'          " TODO writing
call plug#end()

" --- Vim Settings ---
" folddigest TODO
let g:folddigest_options = 'vertical, flexnumwidth'
let g:folddigest_size = 30

" ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1

" TODO - use deoplete for front-end of completion engine?
let g:ale_completion_enabled = 0
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

" TODO
let b:ale_fixers = {'python': ['black', 'isort'], 'javascript': ['xo']}
let b:ale_linters = {'python': ['pyflakes'], 'javascript': ['xo']}

" FZF
let g:fzf_preview_window = 'right:60%'
let g:fzf_buffers_jump = 1

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" editing
set expandtab                     " expand tabs to spaces
set tabstop=4                     " tabs are 4 spaces
set shiftwidth=4                  " reindents are 4 spaces
set smartindent                   " determines indentation with context
set magic                         " enable regex
set formatoptions+=j              " delete comment character when joining lines
set clipboard=unnamedplus         " shared system clipboard
set textwidth=0                   " line wrap
set wrapmargin=0
set undofile                      " undo history persists across sessions


" search
set incsearch                     " highlight as characters are entered
set hlsearch                      " persistent highlight of prev search
set smartcase                     " ignore case if search all lowercase
set wildmenu                      " show menu of suggestions with tab-complete

" performance
set lazyredraw                    " only redraw components on change
set nobackup                      " remove backups
set nowritebackup
set noswapfile
set hidden                        " cache more
" set history=100
set complete-=5                   " limit autocomplete

" pane organization
set splitbelow  " sensible splits
set splitright

" visual
syntax on                         " syntax highlighting
filetype plugin indent on        " file type detection
colorscheme onedark               " one dark colors
set number                        " cur line number
set relativenumber                " relative line numbers
set cursorline                    " current line is visible
set showmatch                     " show matching braces
syntax enable                     " enable syntax highlighting
highlight Comment gui=italic |    " make comments italic
set foldmethod=indent
let g:limelight_conceal_ctermfg = 'Gray'
let g:gitgutter_sign_column_always=1 " always display gutter

if (empty($TMUX))
    if (has('nvim'))
        " $NVIM_TUI_ENABLE_TRUE_COLOR=1
     endif
    if (has('termguicolors'))
        set termguicolors
    endif
endif
" NERDTree settings
let NERDTreeShowHidden=1

" coc configuration" Better display for messages
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set nowritebackup



" --- Key Mappings ---
let mapleader=" "

" --- Text Navigation ---
" travel by visible lines
map j gj
map k gk

" Y behavior consistent with C and D
nnoremap Y y$
" select entire file
nnoremap <leader>V ggVG

" search for current selection in visual mode
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" cancel search with esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" --- Vim Navigation ---
" toggle with previous file
" TODO wish this toggled between open tabs instead
nnoremap <Leader><Leader> :e#<CR>

" toggle between buffers
map <leader>h <C-W>h
map <leader>j <C-W>j
map <leader>k <C-W>k
map <leader>l <C-W>l

" split window management
nnoremap <leader>wc  :sp<CR>
nnoremap <leader>wv  :vsp<CR>
nnoremap <leader>wx  <C-W>c

" tab management
nnoremap <leader>tn  :tabnew<CR>
nnoremap <leader>tc  :tabclose<CR>
nnoremap <leader>tj  :tabprev<CR>
nnoremap <leader>tk  :tabnext<CR>

" Opens a new tab with the current buffer's path
" map <leader>te :tabedit <CR> :=expand("%:p:h")<CR> TODO

" --- Program Usage
nmap <leader>n      : NERDTreeToggle<CR>
nmap <leader>f      :FZF<CR>
" nmap <leader>tf     : NERDTreeFind<CR>

" git
nmap <leader>g     :Gstatus<CR>

" view undo tree
map <leader>u      : UndotreeToggle<CR>

" look through yank buffers to paste
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" enter focus mode
map <leader>f      : Goyo<CR>
autocmd! User GoyoEnter Limelight  | set cursorline! | :CocDisable
autocmd! User GoyoLeave Limelight! | set cursorline  | :CocEnable

" repl integration TODO
map <leader>rf     : TREPLSendFile
map <leader>rl     : TREPLSendLine
map <leader>rs     : TREPLSendSelection

" --- Convenience
" reload vimrc
command! ReloadVim source ~/.vimrc
command! EditVimrc :edit ~/.vimrc
map <leader>rr     :source ~/.vimrc<CR>

command! -range FormatShellCmd <line1>!format_shell_cmd.py | " format shell command TODO

" --- Event Listeners ---

" nerdtree opens in current dir
autocmd BufEnter * lcd %:p:h |

" remove trailing whitespace on save
" https://gitlab.com/kmidkiff/vim-configuration/-/blob/master/vimrc
autocmd BufWritePre * :%s/\s\+$//e |

" smaller indentation for html, css
autocmd FileType css    setlocal shiftwidth=2 tabstop=2
autocmd FileType html   setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal nofoldenable
