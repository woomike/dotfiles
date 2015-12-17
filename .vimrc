" Vundle setup
" ============================================================================
" to install: vim +PluginInstall +qall

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" plugins
" ============================================================================
Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'                      " Fuzzy finder
Plugin 'tpope/vim-commentary'

"Plugin 'fatih/vim-go'                        " Go development plugin
Plugin 'majutsushi/tagbar'                   " class outline viewer

" snippets (all 4 needed)
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" github commment (both needed)
" Plugin 'mmozuras/vim-github-comment'
" Plugin 'mattn/webapi-vim'

" tag line
Plugin 'itchyny/lightline.vim'
" auto pair () and {}
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'rking/ag.vim' 

call vundle#end()            " required

filetype plugin indent on
syntax enable

" everything I copy goes to the system's clipboard
set clipboard=unnamed

:imap jj <Esc>
" hh is easier than esc
inoremap hh <ESC>
" ; is easier than :
nnoremap ; :

set expandtab
set softtabstop=2
set shiftwidth=2
set tabstop=2
set smarttab
set autoindent
set textwidth=0
set showtabline=0
set laststatus=1
set cursorline
set number
set hidden     " allow no write movement b/w buffers

set hlsearch   " highlight search
set ignorecase " Ignore case when searching
set smartcase  " Ignore case when searching lowercase

set backspace=2 "Allow backspace, wtf
set scrolloff=5 "Buffer 4 lines while scrolling


" set leader key
let mapleader = ","
let maplocalleader = ","

" buffers ctrl + jkl
map <C-j> <Esc>:bp<CR>
map <C-k> <Esc>:bn<CR>
map <C-d> <Esc>:bd<CR>
"close buffer but no split
map <C-x> <Esc>:b#<bar>bd#<CR>
" Ag search files
map <C-o> <Esc>:Ag<Space>

"<c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Show extra space in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
"
" remove whitespace with ,w
:noremap <leader>w :%s/\s\+$//<CR>
"
:noremap <leader>v :vsp<CR>:enew<CR>:pwd<CR>
:noremap <leader>s :split<CR>:enew<CR>:pwd<CR>

" use leader key to move splits
:noremap <leader>l <C-w>l
:noremap <leader>h <C-w>h
:noremap <leader>j <C-w>j
:noremap <leader>k <C-w>k

" leader key moves split windows
:noremap <leader>L <C-w>L
:noremap <leader>H <C-w>H
:noremap <leader>J <C-w>J
:noremap <leader>K <C-w>K

" CtrlP
" ============================================================================
" Change mapping
" let g:ctrlp_map = '<leader>t'
" Setup ctrlp (& vim) to use ag search.
if executable('ag')
" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
endif
" Don't update the ctrlp window until I'm done typing.
let g:ctrlp_lazy_update = 1
" Tell ctrlp plugin to ignore the specified patterns.
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist/*'
" path matching mode.
let g:ctrlp_by_filename = 0
" Increase the max_files limit for ctrlp so I can search the adobe directory.
let g:ctrlp_max_files = 0 " Zero means unlimited.
" Increase the maximum depth that ctrlp will search through the directory tree.
let g:ctrlp_max_depth = 100

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction

"set to 256 color
" let &t_Co=256

set background=dark
" solarized options 
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
colorscheme solarized

map <F1> :e.<CR>
nnoremap <F2> :set nonumber!<CR>
set pastetoggle=<F3> " hit this before pasting to fix indentation
nnoremap <F3> :set invpaste paste?<CR>
set pastetoggle=<F3>

" Set Swap directory
set directory=~/.backup/vim/swap

" Persistent undo
" ============================================================================
set undofile                " Save undo's after file closes
set undodir=/tmp " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
