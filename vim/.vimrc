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
Plug 'wincent/terminus'           " better tmux support TODO
" Plug 'godlygeek/tabular'          " text alignment
Plug 'junegunn/vim-easy-align'    " text alignment TODO
Plug 'farmergreg/vim-lastplace'   " save place in file TODO
Plug 'editorconfig/editorconfig'  " support for editor config TODO
Plug 'matze/vim-move'             " move lines without cut-paste TODO
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion and snippet support
" TODO coc suggests a lot of defaults to be incorporated, consider those
Plug 'tomtom/tcomment_vim'        " autocomment support
Plug 'tpope/vim-repeat'           " improves repeats TODO
Plug 'wellle/targets.vim'         " better targeting text TODO
Plug 'ervandew/supertab'          " autocomplete with tab TODO this conflicts with other tab stuff
Plug 'mbbill/undotree'            " undo tree
Plug 'scrooloose/syntastic'       " syntax checking

" navigation
Plug 'scrooloose/nerdtree'        " directory navigation TODO
Plug 'tpope/vim-projectionist'    " navigation of related files TODO
Plug 'wincent/loupe'              " improves search TODO
Plug 'bkad/CamelCaseMotion'       " keybinds for navigating camelcase TODO
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finding
Plug 'junegunn/fzf.vim'

" appearance
Plug 'vim-airline/vim-airline'    " status bar
Plug 'junegunn/goyo.vim'          " minimalist vim
Plug 'junegunn/limelight.vim'     " highlight current paragraph
Plug 'joshdick/onedark.vim'       " one dark theme for vim
Plug 'blueyed/vim-diminactive'    " dims inactive windows TODO
Plug 'camspiers/lens.vim'         " auto window resizing TODO
Plug 'nathanaelkane/vim-indent-guides' " indentation guidelines TODO
Plug 'airblade/vim-gitgutter'     " displays git diff info

" tools
Plug 'kassio/neoterm'             " repl in vim
" Plug 'voldikss/vim-floaterm'      " floating terminal in vim
" TODO which one? how do i configure these?

" specific file type support
Plug 'jceb/vim-orgmode'           " orgmode
Plug 'plasticboy/vim-markdown'    " markdown
Plug 'ekalinin/Dockerfile.vim'    " docker
call plug#end()

" --- Vim Settings ---

" editing
set expandtab                     " expand tabs to spaces
set tabstop=4                     " tabs are 4 spaces
set shiftwidth=4                  " reindents are 4 spaces
filetype indent on                " not sure how this and below react
filetype plugin on                " uhh
filetype plugin indent on         " indentation!
set smartindent                   " determines indentation with context
set autoindent                    " uses prev line indentation
set magic                         " enable regex
set formatoptions+=j            " delete comment character when joining lines TODO

set clipboard=unnamedplus         " shared system clipboard

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
set history=100
set complete-=5                   " limit autocomplete

" visual
syntax on                         " syntax highlighting
filetype on                       " detects file type
colorscheme onedark               " one dark colors
set number                        " line numbers
set relativenumber                " relative line numbers
set cursorline                    " current line is visible
set showmatch                     " show matching braces
syntax enable                     " enable syntax highlighting
highlight Comment gui=italic | " make comments itali
let g:limelight_conceal_ctermfg = 'Gray' " dark comments
let g:gitgutter_sign_column_always=1 " always display gutter

" from https://github.com/joshdick/onedark.vim
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
    if (has("nvim"))
        "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
"        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
     endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" NERDTree settings
let NERDTreeShowHidden=1


" --- Key Mappings ---
" leader key is space
let mapleader=" "

" toggle nerdtree
nmap <leader>n      : NERDTreeToggle<CR>
nmap <leader>j      : NERDTreeFind<CR>
" enter focus mode
map <leader>f      : Goyo<CR>

" reload vim
map <leader>rr     : source ~/.vimrc<CR>

" view undo tree
" TODO improve ergonomics
map <leader>u      : UndotreeToggle<CR>

" repl integration
map <leader>rf     : TREPLSendFile
map <leader>rl     : TREPLSendLine
map <leader>rs     : TREPLSendSelection

" faster window movement
map <C-j> <C-W>k
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" close current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" toggle between buffers
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" TODO: easy way to split screen

" tab management
nnoremap <leader>t  :tabnew<CR>
nnoremap <leader>c  :tabclose<CR>
nnoremap <leader>j  :tabprev<CR>
nnoremap <leader>k  :tabnext<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" search for current selection in visual mode
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" cancel a search with Esc
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" reopen previous file
nnoremap <Leader><Leader> :e#<CR>

" travel by visible lines
map j gj
map k gk

" Y behavior consistent with C and D
nnoremap Y y$

" --- Event Listeners ---
" Goyo triggers focus mode
autocmd! User GoyoEnter Limelight  | set cursorline! | :CocDisable
autocmd! User GoyoLeave Limelight! | set cursorline  | :CocEnable

" nerdtree opens in current dir
autocmd BufEnter * lcd %:p:h

" remove trailing whitespace on save
" https://gitlab.com/kmidkiff/vim-configuration/-/blob/master/vimrc
autocmd BufWritePre * :%s/\s\+$//e

" smaller indentation for html, css
autocmd FileType css    setlocal shiftwidth=2 tabstop=2
autocmd FileType html   setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal nofoldenable



" to look into:
" - folding (vim-clean-fold)
" - fzf
" - doge : documentation generation
" - vimtex : editing latex files [also check out go, rust, etc]
" - vim-table-mode: better editing of markdown tables
" - fugitive git
" - mergetool : helps with merge
" - https://github.com/camspiers/dotfiles/blob/master/files/.config/nvim/init.vim
" - in the future, simplify vim. http://karolis.koncevicius.lt/posts/porn_zen_and_vimrc/
" - generating autotemplate files https://medium.com/@akashrrao/how-i-use-vim-for-competitive-programming-1f0fc96682e0
" - good defaults https://github.com/amix/vimrc/blob/master/vimrcs/basic.vim
" - jedi-vim autocompletion
" vim js, vim typescript, vim jsx, vim graphql
" https://www.reddit.com/r/vim/comments/bfxr2z/vim_theory_and_reflections/ vim theory
" https://github.com/sdothum/dotfiles/tree/master/vim dive into this
" vim for embedded development
" https://www.bbkane.com/2020/04/14/Long-Shell-Oneliners-Without-the-Pain.html
" autoformat shell commands
" http://vimsheet.com/ -- vim cheatsheet for a lot of common vim things to do!
" https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#122011
" https://stevelosh.com/blog/2012/10/a-modern-space-cadet/ -- someone's writing on
" their stuff!
" https://hackaday.com/2016/08/08/editor-wars-the-revenge-of-vim
" cw j -> left, cw k -> right
" ; -> repeats movement
" . -> repeats previous type
" caw : change a word
" cas : change a sentence!
" ci) : changes inside parentheses
" c5w : change next 5 words!
" snipe: finds with two characters
" - abolish.vim : abbreviations, substitutions, coersion : coerce to dask, snake
"   case, etc --
" https://www.reddit.com/r/olkb/comments/6feemo/creating_a_layer_for_vimhjkl_when_using_an/
" https://github.com/SirVer/ultisnips -- snippets in vim :: these are shortcuts that cna expand to other th    ings
" ie snippets appear and disappear when things are selected or not
" snippets are very useful while programming-- easily insert a license block
" parinfer :: insert parentheses automatically
" http://thedarnedestthing.com/space%20vim
" https://www.sbf5.com/~cduan/technical/vi/index.shtml writing on vi, vim, and other things, with a warning of a potential black hole!
" https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally --
" splitting windows in vim, horizontically and vertically
" https://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping
" http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/ -- git wrapper for vim
" https://github.com/airblade/vim-gitgutter -- shows git diff markers
" https://github.com/dense-analysis/ale -- async syntax checker
" https://github.com/mattn/emmet-vim expands abbreviations, not really sure!
" https://github.com/editorconfig/editorconfig-vim -- individual editor
" configuration
" https://github.com/tpope/vim-eunuch -- unix functions in vim
" https://github.com/terryma/vim-multiple-cursors -- multiple cursor typing in
" vim!
" https://stackoverflow.com/questions/4237817/configuring-vim-for-c -- vim for c
" and cPP: do if needed
" https://vimawesome.com/plugin/syntastic -- make sure to track awesome vim!
" https://github.com/sdothum/dotfiles/tree/master/vim/.vim -- check out this
" configuration!!!
" https://github.com/neoclide/coc.nvim -- the autofill configuration that i really
" need
" https://www.bugsnag.com/blog/tmux-and-vim -- simplify vim split navigation and
" other things
" https://www.hillelwayne.com/post/intermediate-vim/
" https://github.com/ghing/vim-config/blob/master/vimrc check out this vimrc
" https://github.com/yangmillstheory/vim-snipe
" https://developer.ibm.com/technologies/systems/tutorials/au-customize_vi/
" https://dougblack.io/words/a-good-vimrc.html
" https://github.com/amix/vimrc checkout ultimate vimrc
" https://www.barbarianmeetscoding.com/blog/2018/10/24/exploring-vim-setting-up-your-vim-to-be-more-awesome-at-vim
" https://www.reddit.com/r/vim/comments/3h6tef/what_are_your_musthave_configs_and_plugins/
" https://github.com/tpope/vim-unimpaired
" https://github.com/vim-vdebug/vdebug
" https://github.com/tpope/vim-speeddating
" https://github.com/blueyed/vim-diminactive
" https://github.com/camspiers/lens.vim
" https://github.com/tpope/vim-obsession
" https://github.com/sedm0784/vim-you-autocorrect/
" https://github.com/rbong/vim-flog
" https://github.com/reedes/vim-pencil
" https://github.com/svermeulen/vim-easyclip
" https://github.com/glts/vim-radical
" https://github.com/tpope/vim-projectionist
" https://www.reddit.com/r/vim/comments/g4l5p0/good_plugin_to_navigate_buffers/
" https://www.reddit.com/r/vim/comments/g2w8px/what_was_your_mindblown_moments_about_vim/
" https://www.reddit.com/r/vim/comments/gbhvlo/what_am_i_missing_by_not_using_fzf/
" https://github.com/junegunn/fzf.vim
" https://github.com/doctorn/dotfiles/blob/master/.vimrc
" https://github.com/jceb/vimrc
" https://www.reddit.com/r/vim/comments/fzpdpd/im_loving_the_combination_of_vimtex_goyo/
" https://www.reddit.com/r/vim/comments/g68bf6/pathogen_is_dead_or_should_be_long_live_vim_8/
"
