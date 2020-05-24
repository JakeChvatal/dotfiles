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
Plug 'wincent/terminus'           " better tmux support TODO
" Plug 'godlygeek/tabular'          " text alignment
Plug 'junegunn/vim-easy-align'    " text alignment TODO
Plug 'farmergreg/vim-lastplace'   " save place in file TODO
Plug 'editorconfig/editorconfig'  " support for editor config TODO
Plug 'matze/vim-move'             " move lines without cut-paste TODO
Plug 'neoclide/coc.nvim', {'branch': 'release'} " autocompletion and snippet support

Plug 'tomtom/tcomment_vim'        " autocomment support
Plug 'tpope/vim-repeat'           " improves repeats TODO
Plug 'wellle/targets.vim'         " better targeting text TODO
" Plug 'ervandew/supertab'        " autocomplete with tab TODO this conflicts with other tab stuff
" Plug 'scrooloose/syntastic'     " syntax checking TODO can't coc be used for this?
" Plug 'glts/vim-magnum'            " convert to hex, octal etc TODO prob unecessary
" Plug 'glts/vim-radical'
Plug 'svermeulen/vim-yoink'       " cycle between pastes when pasting
" Plug 'svermeulen/vim-subversive'  " quick substitutions with s

nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" navigation
Plug 'scrooloose/nerdtree'        " directory navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy file finding - incredible!
Plug 'junegunn/fzf.vim'

Plug 'jakechvatal/vim-tmux-navigator' "ctrl hjkl, c-c, c-v, c-x navigation
Plug 'tpope/vim-projectionist'    " navigation of related files TODO
Plug 'wincent/loupe'              " improves search TODO
Plug 'bkad/CamelCaseMotion'       " keybinds for navigating camelcase TODO

" appearance
Plug 'vim-airline/vim-airline'    " status bar
Plug 'junegunn/goyo.vim'          " minimalist vim
Plug 'junegunn/limelight.vim'     " highlight current paragraph
Plug 'joshdick/onedark.vim'       " one dark theme for vim
Plug 'camspiers/lens.vim'         " auto window resizing TODO do i really ever need this?
Plug 'airblade/vim-gitgutter'     " displays git diff info

" tools
" Plug 'kassio/neoterm'             " repl in vim
" Plug 'voldikss/vim-floaterm'      " floating terminal in vim
Plug 'tpope/vim-eunuch'             " TODO shell commands
" TODO which one? how do i configure these?

" specific file type support
Plug 'jceb/vim-orgmode'           " orgmode
Plug 'plasticboy/vim-markdown'    " markdown
Plug 'ekalinin/Dockerfile.vim'    " docker
Plug 'fatih/vim-go'               " go
Plug 'andys8/vim-elm-syntax'      " elm
Plug 'reedes/vim-pencil'          " writing in vim TODO
" TODO use language server?
call plug#end()

" --- Vim Settings ---
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
let g:limelight_conceal_ctermfg = 'Gray'
let g:gitgutter_sign_column_always=1 " always display gutter

if (empty($TMUX))
    if (has("nvim"))
        " $NVIM_TUI_ENABLE_TRUE_COLOR=1
     endif
    if (has("termguicolors"))
        set termguicolors
    endif
endif

" NERDTree settings
let NERDTreeShowHidden=1

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

" toggle between screens TODO vim buffer config

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
" toggle nerdtree
nmap <leader>n      : NERDTreeToggle<CR>
" nmap <leader>tf     : NERDTreeFind<CR>

" view undo tree
map <leader>u      : UndotreeToggle<CR>

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
map <leader>rr source ~/.vimrc

command! -range FormatShellCmd <line1>!format_shell_cmd.py | " format shell command TODO

" --- Event Listeners ---

" nerdtree opens in current dir
autocmd BufEnter * lcd %:p:h

" remove trailing whitespace on save
" https://gitlab.com/kmidkiff/vim-configuration/-/blob/master/vimrc
autocmd BufWritePre * :%s/\s\+$//e

" smaller indentation for html, css
autocmd FileType css    setlocal shiftwidth=2 tabstop=2
autocmd FileType html   setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown setlocal nofoldenable

" - folding (vim-clean-fold)
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
" http://vimsheet.com/ -- vim cheatsheet for a lot of common vim things to do!
" https://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim/1220118#122011
" https://stevelosh.com/blog/2012/10/a-modern-space-cadet/ -- someone's writing on
" their stuff!
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
" https://github.com/sdothum/dotfiles/tree/master/vim/.vim -- check out this
" configuration!!!
" https://www.bugsnag.com/blog/tmux-and-vim -- simplify vim split navigation and other things
" https://www.hillelwayne.com/post/intermediate-vim/
" https://github.com/ghing/vim-config/blob/master/vimrc check out this vimrc
" https://github.com/yangmillstheory/vim-snipe
" https://developer.ibm.com/technologies/systems/tutorials/au-customize_vi/
" https://dougblack.io/words/a-good-vimrc.html
" https://github.com/amix/vimrc checkout ultimate vimrc
" https://www.barbarianmeetscoding.com/blog/2018/10/24/exploring-vim-setting-up-your-vim-to-be-more-awesome-at-vim
" https://www.reddit.com/r/vim/comments/3h6tef/what_are_your_musthave_configs_and_plugins/
" https://www.reddit.com/r/vim/comments/g2w8px/what_was_your_mindblown_moments_about_vim/
" https://www.reddit.com/r/vim/comments/gbhvlo/what_am_i_missing_by_not_using_fzf/
" https://www.reddit.com/r/vim/comments/fzpdpd/im_loving_the_combination_of_vimtex_goyo/
" https://www.reddit.com/r/vim/comments/g68bf6/pathogen_is_dead_or_should_be_long_live_vim_8/
