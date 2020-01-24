set clipboard=unnamedplus
set number

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
call plug#end()

if has('gui_running')
  set guifont=Lucida_Console:h11
endif

map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTee.isTabTree()) | q | endif

