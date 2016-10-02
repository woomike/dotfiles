" Vundle setup
" to install: vim +PlugInstall +qall
call plug#begin('~/.vim/plugged')

" Plugins
" ============================================================================

" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'joshdick/onedark.vim'

" Fuzzy finder
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'

" Linting
Plug 'scrooloose/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'

" snippets (all 4 needed)
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

Plug 'itchyny/lightline.vim'        " tag line
Plug 'jiangmiao/auto-pairs'         " auto pair () and {}
Plug 'scrooloose/nerdtree'
Plug 'numkil/ag.nvim'
Plug 'airblade/vim-gitgutter'       " Show +- git diff
Plug 'majutsushi/tagbar'            " class outline viewer

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

" Eslint settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
"Toggle Syntastic check
nnoremap <C-w>e :SyntasticCheck<CR>
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '💩'
let g:syntastic_style_warning_symbol = '⚠️'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

filetype plugin indent on
syntax enable

set background=light
" set background=dark
" solarized options
" let g:solarized_visibility = "high"
" let g:solarized_contrast = "high"
colorscheme solarized
" colorscheme onedark

" everything I copy goes to the system's clipboard
set clipboard=unnamed
" update file automatically when written from somewhere else
set autoread

:imap jj <Esc>
:imap kk <Esc>
inoremap hh <ESC>
nnoremap ; :

" set autoindent noexpandtab tabstop=4 shiftwidth=4 " Wtf tabz =[
set expandtab softtabstop=4 shiftwidth=4 tabstop=4 smarttab autoindent " Spaces
set textwidth=0
set showtabline=2
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

set splitbelow "more natural split placement
set splitright

"Show end of line char
set listchars=eol:¬

" set leader key
let mapleader = " "
let maplocalleader = " "

" Move tabs left and right
" map <C-h> <Esc>:h tabp<CR>
" map <C-l> <Esc>:tabn<CR>

" buffers ctrl + jkl
map <C-j> <Esc>:bp<CR>
map <C-k> <Esc>:bn<CR>
map <C-d> <Esc>:bd<CR>
map <C-i> <Esc>:tabp<CR>
map <C-o> <Esc>:tabn<CR>

"close buffer but not split
map <C-o> <Esc>:b#<bar>bd#<CR>
" Ag search files
" map <C-o> <Esc>:Ag<Space>
:noremap <leader>o :Ag<Space>

"<c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

" Show extra space in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" paste from 0 register
nnoremap P "0p

" remove whitespace with leader w
:noremap <leader>w :%s/\s\+$//<CR>

" create splits
:noremap <leader>v :vsp<CR>:enew<CR>:pwd<CR>
:noremap <leader>s :split<CR>:enew<CR>:pwd<CR>

" create tab
:noremap <leader>t :tabnew<CR>

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

let NERDTreeShowHidden=1

" Esc when in terminal mode (nvim only)
:tnoremap <Esc> <C-\><C-n>
:tnoremap jj <C-\><C-n>

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

" Set Swap directory
set directory=~/.backup/vim/swap

" Persistent undo
" ============================================================================
set undofile                " Save undo's after file closes
set undodir=/tmp " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

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

