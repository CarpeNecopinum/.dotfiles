set expandtab
set shiftwidth=4
set softtabstop=4

syntax on

set nocompatible

set wildignore=*.o,*.obj,*.class,target/**,build/**
set list
set listchars=tab:\|\ ,trail:~
set wrap
set linebreak
set breakindent
set breakindentopt=shift:2
set display=lastline,uhex
set tabstop=4      " indentation size
set shiftwidth=4
set softtabstop=4
set smarttab       " tabs at the beginning of a line
set expandtab      " always use spaces instead of tab characters
set encoding=utf-8 " default encoding
set history=2000
set showcmd        " display incomplete commands
set wildmenu       " better command line completion
set wildmode=list:longest,full
set lazyredraw     " don't redraw during macros
set confirm        " ask to save on exit
set autoread       " reload file on change
set exrc           " per project vimrc
set secure         " secure local vimrc
set hidden         " allow buffers to be hidden, don't force to write on buffer change

set number
"set relativenumber " enable relative line numbers
"autocmd InsertEnter * :set relativenumber!
"autocmd InsertEnter * :set number
"autocmd InsertLeave * :set number!
"autocmd InsertLeave * :set relativenumber
set numberwidth=5

" plugins
" auto install pluginmanager if not existent
if empty(glob('~/.vim/autoload/plug.vim'))
    !mkdir -p ~/.vim/autoload
    !curl -fLo ~/.vim/autoload/plug.vim
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/bundle')

Plug 'tpope/vim-sensible'       " defaults everyone can agree on
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer'}
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'rking/ag.vim'             " search engine
Plug 'bling/vim-airline'        " good status line
Plug 'rhysd/vim-clang-format'   " clang format integration
Plug 'kien/ctrlp.vim'           " fuzzy file search
Plug 'scrooloose/nerdtree'      " file tree

call plug#end()

let g:ycm_error_symbol = '☠'
let g:ycm_warning_symbol = '⚠'
let g:ycm_extra_conf_globlist = ['/servers/krag/hdd-home3/cmattes/**']

let g:airline_symbols={}
let g:airline_symbols.linenr = 'L' "'␊'
let g:airline_symbols.branch = 'B' "'ψ'
let g:airline_symbols.readonly ='R'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_left_alt_sep = '<'
let g:airline_right_alt_sep = '>'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" nmap <C-m> :ClangFormat<CR>
" vmap <C-m> :Clangformat<CR>

" save undo history
set swapfile
set backup
set undofile
set undodir=~/.vim/tmp/undo//
set backupdir=~/.vim/tmp/backup//
set directory=~/.vim/tmp/swap//

let mapleader = ","

map <F3> :e %:p:s,.hh$,.X123X,:s,.cc$,.hh,:s,.X123X$,.cc,<CR> " swap header and source
map <C-n> :NERDTreeToggle<CR>                                 " open file tree
"auto format source code on clang-format
map <C-K> :pyf ~/.vim/clang-format.py<CR>
"autocmd BufWritePre *.cc :pyf ~/.vim/clang-format.py
nmap <silent> j /{<CR>%<Down>
nmap <silent> k ?}<CR>%<Up>

nnoremap ü :wa<CR>:make<CR>                                   " build the project
nnoremap ö :bd<CR>                                            " close current buffer
nnoremap ä :q<CR>                                             " quit
nnoremap ß @q                                                 " run makro from q (qq to record it)

map <leader>, :YcmCompleter GoToDefinition<CR>
map <leader>. :YcmCompleter GoToDeclaration<CR>
" map <leader>j :YcmCompleter GoToImplementation<CR>
map <leader>t :YcmCompleter GetType<CR>
map <leader>p :YcmCompleter GetParent<CR>
map <leader>g :YcmCompleter GoTo<CR>
map <leader>i :YcmCompleter GoToImprecise<CR>

nmap <silent> <F5> :bprevious<CR>
nmap <silent> <F6> :bnext<CR>
nmap <silent> <F7> :cprevious<CR>
nmap <silent> <F8> :cnext<CR>

filetype plugin indent on
syntax on
colorscheme desert

map <C-s> :wa<CR>

" Automatically close scratch window after autocomplete
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
