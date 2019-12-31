" vim-plug
call plug#begin('~/.vim/plugged') "
Plug 'scrooloose/nerdtree'		" NerdTree navigation
Plug 'jiangmiao/auto-pairs'         	" Auto pair () and {}
Plug 'Xuyuanp/nerdtree-git-plugin'	" Show git status on files
Plug 'kien/ctrlp.vim'			" Fuzzy file finder
Plug 'tpope/vim-commentary'		" Comment with gcc
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] } " Search all files
call plug#end()

" Plugin Settings
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 20
" Prevents NERDTree from opening twice and using Netrw in buffer
let g:NERDTreeHijackNetrw=0
augroup NERDTreeHijackNetrw
    autocmd VimEnter * silent! autocmd! FileExplorer
augroup END
autocmd VimEnter * NERDTree
" Ctrlp ignores certain folders
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|optimized|compiled'

" Remap for easy insert / command toggle
:imap jj <Esc>
:imap kk <Esc>
inoremap hh <ESC>
nnoremap ; :

let iterm_profile = $ITERM_PROFILE

" Follows whatever iTerm is for coloring
if iterm_profile == "Dark"
    set background=dark
else
    set background=light
endif

" Use the system clipboard
set clipboard+=unnamedplus
" Enable mouse in Normal, Visual, Insert, and Command-Line modes
set mouse=nvic
" No write movement between buffers
set hidden
" Update file automatically when written from somewhere else
set autoread

set hlsearch   " Highlight search
"<c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

set ignorecase " Ignore case when searching
set smartcase  " Ignore case when searching lowercase
" More natural split placement
set splitbelow
set splitright
" Colors in your font
set t_Co=256
set nospell " See text when highlighting
" Numbers
set number
set nowrap
" Tabs are spaces
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab


" Start at last position
set laststatus=1
" Shows line below cursor (pair programming help)
set cursorline

" Set leader key to spacebar
let mapleader = " "
let maplocalleader = " "

" Create splits
:noremap <leader>v :vsp<CR>:enew<CR>:pwd<CR>
:noremap <leader>s :split<CR>:enew<CR>:pwd<CR>
" Use leader key to move splits
:noremap <leader>l <C-w>l
:noremap <leader>h <C-w>h
:noremap <leader>j <C-w>j
:noremap <leader>k <C-w>k
" leader key moves split windows
:noremap <leader>L <C-w>L
:noremap <leader>H <C-w>H
:noremap <leader>J <C-w>J
:noremap <leader>K <C-w>K
" Save with enter key
nnoremap <unique> <CR> :w<CR>
" Grepper set to leader + o
nnoremap <leader>F :Grepper<CR>
" Don't save on location list
au FileType qf nnoremap <buffer> <Enter> <Enter>
" Persistent undo
set undofile                " Save undo's after file closes
set undodir=/tmp " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
" Cursor configuration {{{
" Use a blinking upright bar cursor in Insert mode, a solid block in normal
" and a blinking underline in replace mode
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
  let &t_SI = "\<Esc>[5 q"
  let &t_SR = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[2 q"
" }}}

" Closes buffers and not the split, quits split if no buffers
function! CloseBuffer()
    let curBuf = bufnr('%')
    let curTab = tabpagenr()
    exe 'bnext'

    " If in last buffer, create empty buffer
    if curBuf == bufnr('%')
        exe 'q'
    endif

    " Loop through tabs
    for i in range(tabpagenr('$'))
        " Go to tab (is there a way with inactive tabs?)
        exe 'tabnext ' . (i + 1)
        " Store active window nr to restore later
        let curWin = winnr()
        " Loop through windows pointing to buffer
        let winnr = bufwinnr(curBuf)
        while (winnr >= 0)
            " Go to window and switch to next buffer
            exe winnr . 'wincmd w | bnext'
            " Restore active window
            exe curWin . 'wincmd w'
            let winnr = bufwinnr(curBuf)
        endwhile
    endfor

    " Close buffer, restore active tab
    exe 'bd' . curBuf
    exe 'tabnext ' . curTab  
endfunction
nmap ,d :call CloseBuffer()<CR>
