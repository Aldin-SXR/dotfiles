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

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rakr/vim-one'
Plugin 'ryanoasis/vim-devicons'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'elixir-lang/vim-elixir'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden = 1
map <C-b> :NERDTreeToggle<CR>
let g:NERDTreeLimitedSyntax = 1

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
set laststatus=2
let g:airline_theme='one'

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 'ra'

" Elite mode
let g:elite_mode=1

" TAB commpletion
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Switch and close buffers
noremap <silent> <C-x> :bn \| bd #<CR>
noremap <silent> <C-e> :bn<CR>
noremap <silent> <C-q> :bp<CR> 

augroup vimrc_autocmd
    autocmd!
    " NERDTree settings
    autocmd vimenter * NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    " Autocomplete settings
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown
    " Auto-compile Markdown to PDF (requires Pandoc)
    autocmd BufWritePost *.md execute ':silent ! file=%; pandoc $file -s -o $file.pdf'
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
