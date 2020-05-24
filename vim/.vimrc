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
" Plug 'sjl.gundo.vim TODO try this plugin out
Plug 'wincent/terminus'           " better terminal integration
Plug 'farmergreg/vim-lastplace'   " save place in file
Plug 'junegunn/vim-easy-align'    " align text
Plug 'matze/vim-move'             " move lines without cut-paste TODO
Plug 'tomtom/tcomment_vim'        " autocomment support TODO make use of this!
Plug 'tpope/vim-repeat'           " improves repeats
Plug 'vim-scripts/visualrepeat'   " repeat in visual mode
Plug 'wellle/targets.vim'         " better targeting text for operating inside TODO make use of this!
Plug 'svermeulen/vim-yoink'       " cycle between pastes when pasting
Plug 'dense-analysis/ale'         " linting
Plug 'tpope/vim-unimpaired'       " bracket mapping
" Plug 'kana/vim-textobj-user'      " create custom text objects TODO
Plug 'mattn/emmet-vim'   " expanding abbreviations
Plug 'sirver/ultisnips'  " snippet engine
Plug 'honza/vim-snippets' " custom snippets

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" navigation
Plug 'scrooloose/nerdtree'        " directory navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finding - incredible!
Plug 'junegunn/fzf.vim'

Plug 'chrisbra/NrrwRgn' " narrow region for editing file in new buffer
Plug 'ervandew/supertab'  " perform insert mode autocomplete with tab
" TODO figure out how to stop supertab after quote
Plug 'bogado/file-line' " edit file with vim and goto line TODO
Plug 'vim-scripts/multisearch.vim' " multiple search queries at once TODO map
Plug 'yangmillstheory/vim-snipe' " quick navigation ! TODO bind
Plug 'jceb/vim-shootingstar'     " leader * for searching for subpart of text TODO
Plug 'mhinz/vim-sayonara'        " sensibly close buffer

" appearance
Plug 'vim-airline/vim-airline'    " status bar
Plug 'junegunn/goyo.vim'          " minimalist vim
Plug 'junegunn/limelight.vim'     " highlight current paragraph
Plug 'joshdick/onedark.vim'       " one dark theme for vim
Plug 'camspiers/lens.vim'         " auto window resizing TODO do i really ever need this?
Plug 'vim-scripts/folddigest.vim' " displays folds as summary
" Plug 'tpope/vim-rsi'              " emacs/shell shortcuts in vim TODO learn these shortcuts!

" git
Plug 'airblade/vim-gitgutter'     " displays git diff info
Plug 'tpope/vim-fugitive'         " vim convenience functions
Plug 'rbong/vim-flog'             " vim branch viewer TODO

" tools
Plug 'Chiel92/vim-autoformat'       " autoformatting
Plug 'kassio/neoterm'               " repl in vim TODO
Plug 'tpope/vim-eunuch'             " TODO shell commands - see if these are used
" Plug 'majutsushi/tagbar'            " view class outline TODO requires ctags
" Plug 'craigemery/vim-autotag'      " autogen ctags
" Plug 'reedes/vim-litecorrect'       " autocorrect for prose

" specific file type support
Plug 'sheerun/vim-polyglot'         " syntax highlighting
Plug 'jceb/vim-orgmode'             " TODO really just uses vim folds
" Plug 'reedes/vim-pencil'          " TODO writing
Plug 'mhinz/vim-startify'           " start menu
call plug#end()

" --- Vim Settings ---
" folddigest
" TODO
" - improve look of digest
" - toggle digest
let g:folddigest_options = 'vertical, flexnumwidth'
let g:folddigest_size = 30

" ALE
" Use ALE and also some plugin 'foobar' as completion sources for all code.
call deoplete#custom#option('sources', {
\ '_': ['ale'],
\})

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_completion_tsserver_autoimport = 1 " autoimport ts server
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

" TODO
let b:ale_fixers = {'python': ['black', 'isort'], 'javascript': ['xo']}
let b:ale_linters = {'python': ['pyflakes'], 'javascript': ['xo']}

" FZF
let g:fzf_preview_window = 'right:60%'
let g:fzf_buffers_jump = 1

" utilsnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" autoformat
au BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

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

" folding
set foldenable " turn on folding
set foldmethod=marker
set foldlevelstart=0

" performance
set lazyredraw                    " only redraw components on change
set nobackup                      " remove backups
set nowritebackup
set noswapfile
set hidden                        " cache more
set history=1000                  " default is 20
set complete-=5                   " limit autocomplete
set scrolloff=3                 " scroll 3l in advance of window
set backspace=2                 " backspace is normal

" https://github.com/dm3/cygwin-config/blob/master/.vimrc
" show hidden characters and linewraps
" TODO make sure this works on other devices
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮
set showbreak=↪
set completeopt=longest,menu,menuone
"               |       |    +-- Show popup even with one match
"               |       +------- Use popup menu with completions
"               +--------------- Insert longest completion match
set wildmode=longest:full,list:full
"            |            +-- List matches, complete first match
"            +--------------- Complete longest prefix, use wildmenu

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
set background=dark
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
let NERDTreeShowHidden=1 " show hidden files
let NERDTreeMinimalUI = 1 " minimal ui
let NERDTreeChDirMode = 2 " change cwd with root dir
let NERDTreeHijackNetrw = 1 " always use nerdtree

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
" paragraph formatting
nnoremap Q gqap
vnoremap Q gq

" search for current selection in visual mode
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" cancel search with esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" --- Vim Navigation ---

" commonly used shortcuts
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>.    :NERDTreeToggle<CR>
" toggle with previous file
nnoremap <Leader><Leader> :e#<CR>

" a ::
" b ::

" c :: Close
nmap <leader>cc    :Sayonara<CR>
nmap <leader>cn    :Sayonara!<CR>

" d ::

" e :: Edit
" edit vim config files (if they exist) TODO
function! EditConfig(config)
    if exists(a:config)
        execute 'tabedit '.a:config
    endif
endfunction

nnoremap <leader>ec    :edit ~/.vimrc<CR>

" f :: Find
" TODO: file path completion in edit mode
nmap <leader>ff     :Files<CR>
nmap <leader>fw     :Windows<CR>
nmap <leader>fh     :History<CR>
nmap <leader>ft     :Tags<CR>
nmap <leader>fc     :Commits<CR>
nmap <leader>fl     :Lines<CR>
nmap <leader>fb     :Buffers<CR>
nmap <leader>fg     :Gfiles<CR>
" nmap <leader>fm     :Marks<CR> TODO learn marks; swap with maps
" nmap <leader>fs     :Snippets<CR> TODO
nmap <leader>fc     :Commands<CR>
nmap <leader>fm     :Maps<CR>
nmap <leader>ft     :NERDTreeFind<CR>

" g :: Git
nmap <leader>gs    :Gstatus<CR>

" i ::

" m :: Mode
map <leader>mf      :Goyo<CR>
autocmd! User GoyoEnter Limelight  | set cursorline!
autocmd! User GoyoLeave Limelight! | set cursorline

" n ::

" o :: Open
nmap <leader>og    :Gstatus<CR>
nmap <leader>of    :NERDTreeToggle<CR>
nmap <leader>ou    :UndotreeToggle<CR>
nmap <leader>og    :call FoldDigest()<CR>
nmap <leader>ot    :TagbarToggle<CR>
vmap o :NR<CR>
" open visual selection in new window

" p ::
" q ::

" r :: REPL
map <leader>rf     : TREPLSendFile
map <leader>rl     : TREPLSendLine
map <leader>rs     : TREPLSendSelection
" r :: Reload
map <leader>rr     :source ~/.vimrc<CR>
map <leader>rp     :source ~/.vimrc<CR>:PlugInstall<CR>

" s :: Snipe TODO
" map <leader>s <Plug>(snipe-f)
" map <leader><leader>ge <Plug>(snipe-ge)
" nmap <leader><leader>] <Plug>(snipe-f-xp)
" nmap <leader><leader>[ <Plug>(snipe-F-xp)
" nmap <leader><leader>x <Plug>(snipe-f-x)
" nmap <leader><leader>X <Plug>(nipe-F-x)
" nmap <leader><leader>r <Plug>(snipe-f-r)
" nmap <leader><leader>R <Plug>(snipe-F-r)
" nmap <leader><leader>a <Plug>(snipe-f-a)
" nmap <leader><leader>A <Plug>(snipe-F-a)

" t :: Tab
nnoremap <leader>tn  :tabnew<CR>
nnoremap <leader>tc  :tabclose<CR>
nnoremap <leader>tj  :tabprev<CR>
nnoremap <leader>tk  :tabnext<CR>

" Browser-similar tab navigation
nnoremap <C-T> :tabnew<CR>
nnoremap <C-W> :tabclose<CR>
nnoremap <C-J> :tabprev<CR>
nnoremap <C-K> :tabnext<CR>

" Opens a new tab with the current buffer's path
" map <leader>te :tabedit <CR> :=expand("%:p:h")<CR> TODO

" u :: Undo
map <leader>u      :UndotreeToggle<CR>

" v ::

" w :: (split) Window
nnoremap <leader>wh  :sp<CR>
nnoremap <leader>wv  :vsp<CR>
nnoremap <leader>wc  <C-W>c

" x :: Execute?

" y :: Yank
nmap <leader>yh <plug>(YoinkPostPasteSwapBack)
nmap <leader>yl <plug>(YoinkPostPasteSwapForward)
nmap <leader>yp <plug>(YoinkPaste_p)
nmap <leader>yP <plug>(YoinkPaste_P)

" z ::

"
" --- Event Listeners ---

" command! -range FormatShellCmd <line1>!format_shell_cmd.py | " format shell command TODO
" nerdtree opens in current dir
autocmd BufEnter * lcd %:p:h |

" remove trailing whitespace on save
" https://gitlab.com/kmidkiff/vim-configuration/-/blob/master/vimrc
autocmd BufWritePre * :%s/\s\+$//e |

" smaller indentation for html, css
autocmd FileType css    setlocal shiftwidth=2 tabstop=2
autocmd FileType html   setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal nofoldenable " fold may not work with markdown?
