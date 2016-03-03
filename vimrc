" Vundle setup
" ============================================================================
" to install: vim +PlugInstall +qall

call plug#begin('~/.vim/plugged')

" Plugins
" ============================================================================
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
Plug 'kien/ctrlp.vim'                      " Fuzzy finder
Plug 'tpope/vim-commentary'

Plug 'majutsushi/tagbar'                   " class outline viewer

" snippets (all 4 needed)
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
" Plug 'ludovicchabant/vim-gutentags' "Find functions in other files

" github commment (both needed)
" Plug 'mmozuras/vim-github-comment'
" Plug 'mattn/webapi-vim'

Plug 'itchyny/lightline.vim'        " tag line
Plug 'jiangmiao/auto-pairs'         " auto pair () and {}
Plug 'scrooloose/nerdtree'
Plug 'rking/ag.vim'
Plug 'airblade/vim-gitgutter'       " Show +- git diff

" Plug 'Shougo/deoplete.nvim'         "auto complete

" Go stuff
Plug 'fatih/vim-go'
 " au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
 au FileType go nmap <Leader>gd <Plug>(go-doc-browser)
 au FileType go nmap <leader>gr <Plug>(go-run)
 au FileType go nmap <leader>gb <Plug>(go-build)
 au FileType go nmap <leader>gx <Plug>(go-build) <Plug>(go-run)
 let g:go_auto_type_info = 1
 let g:go_highlight_functions = 1
 let g:go_highlight_methods = 1
 let g:go_highlight_structs = 1
 let g:go_highlight_operators = 1
 let g:go_highlight_build_constraints = 1
 " add missing imports on save
 let g:go_fmt_command = "goimports"
call plug#end()

" vundle stuff? maybe not needed anymore
" set nocompatible              " be iMproved, required
" filetype off                  " required

filetype plugin indent on
syntax enable

set background=dark
" solarized options
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
" colorscheme solarized
colorscheme onedark

" everything I copy goes to the system's clipboard
set clipboard=unnamed
" update file automatically when written from somewhere else
set autoread

:imap jj <Esc>
:imap kk <Esc>
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
set scrolloff=5 "Buffer 5 lines while scrolling

set textwidth=80 "Show past 80 characters
set colorcolumn=+1

"Show end of line char
set listchars=eol:¬
set spell
setlocal spell spelllang=en_us

" set leader key
let mapleader = " "
let maplocalleader = " "

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

" create splits
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

" leader key fixes indentation
:noremap <leader>i mzgg=G`z

" save with enter key
nnoremap <unique> <CR> :w<CR>
" Don't save on location list
au FileType qf nnoremap <buffer> <Enter> <Enter>

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
let &t_Co=256


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

" Use deoplete.
" let g:deoplete#enable_at_startup = 1

set path=$PWD/** " Set search path so it will look in project directory
" When opening with 'gf' search for the file extension and add
autocmd FileType <filetype> setl suffixesadd+=<exts>

" :echo b:current_syntax Find out file syntax for associations
augroup suffixes
    autocmd!

    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json"],
                \["html", ".html"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

" Cursor configuration {{{
" ====================================================================
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}

"Fold function
map <leader>f <Esc>:execute "normal! V$%zf"<CR>
