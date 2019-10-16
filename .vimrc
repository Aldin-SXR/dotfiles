set nocompatible              " be iMproved, required
filetype off                  " required
syntax on

" Wrap settings
set wrap       
set linebreak       
set textwidth=0
set wrapmargin=0

" Search settings
set autoread
set hlsearch
set incsearch
set ignorecase
let mapleader=","
nnoremap <leader><space> :nohlsearch<CR>

" Visual settings
set encoding=UTF-8
set number
set ruler
set t_Co=256
set cursorline  
set backspace=indent,eol,start

" No backup/swap
set nobackup
set nowb
set noswapfile

autocmd! GUIEnter * set vb t_vb=
set wildmenu
set wildmode=list:longest
set showmatch

" System clipboard
if has('clipboard')
    if has('unnamedplus')  " When possible use + register for copy-paste
        set clipboard=unnamed,unnamedplus
    else         " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif
set hidden

" Proper tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set nocindent
set ai
set si
filetype indent on

" Speed optimization
set ttyfast
set lazyredraw

" Set the runtime path to include Vim-Plug and initialize
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rakr/vim-one'
Plug 'ryanoasis/vim-devicons'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-eunuch'

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on    " required

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1
let g:NERDTreeLimitedSyntax = 1
map <C-b> :NERDTreeToggle<CR>

" FZF mapping
map <C-p> :Files<CR>

" autocmd BufWinEnter * NERDTreeMirror
" autocmd VimEnter * wincmd w

" NERDTree Tabs config
let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus=1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗ ",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" Airline settings
colorscheme one
set background=light
let base16colorspace=256

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled=1
let g:airline_theme='one'
set laststatus=2

" Elite mode
let g:elite_mode=1

" TAB completion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Switch and close buffers
noremap <silent> <C-x> :bn \| bd #<CR>
noremap <silent> <C-e> :bn<CR>
noremap <silent> <C-q> :bp<CR> 

" Allow <C-q> mapping
" silent !stty ixon > /dev/null 2>/dev/null

augroup vimrc_autocmd
    autocmd!
    " NERDTree settings
    autocmd vimenter * NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    autocmd BufEnter * lcd %:p:h
    " Autocomplete settings
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    " Auto-compile Markdown to PDF (requires Pandoc)
    autocmd BufWritePost *.md execute ':silent ! file=%; pandoc $file -s -o $file.pdf'
    " Return stty settings to default
    " autocmd VimLeave * silent stty ixon
augroup END

set timeout " Do time out on mappings and others
set timeoutlen=1000 " Wait {num} ms before timing out a mapping
set ttimeoutlen=10

" When you’re pressing Escape to leave insert mode in the terminal, it will by
" default take a second or another keystroke to leave insert mode completely
" and update the statusline. This fixes that. I got this from:
" https://powerline.readthedocs.org/en/latest/tipstricks.html#vim
if !has('gui_running')
   set ttimeoutlen=10
   augroup FastEscape
       autocmd!
       au InsertEnter * set timeoutlen=0
       au InsertLeave * set timeoutlen=1000
   augroup END
endif
