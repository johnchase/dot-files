execute pathogen#infect()

set number
set relativenumber
set autoread
set smarttab
set expandtab

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

set noswapfile
set nobackup
set nowb

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set backspace=2

set hlsearch
set incsearch

set scrolloff=5

autocmd VimResized * wincmd =

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>


" Autocomplete and exit brackets"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

filetype plugin indent on

set colorcolumn=80
set infercase

" Open NERDTree on F2
map <F2> :NERDTreeToggle<CR>

"Show hidden files in NerdTree
"let NERDTreeShowHidden=1
"
""autopen NERDTree and focus cursor in new document
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeWinSize = 50

set mouse=a
set clipboard=unnamed

let g:NERDTreeMouseMode=3

syntax enable
set background=dark
let g:solarized_termcolors=256
"let g:solarized_contrast = "low"

"let g:gruvbox_contrast_dark="low"
"let g:gruvbox_termcolors=256
colorscheme solarized
"colorscheme gruvbox"

" PEP8 formatting
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" Delete whitespace in python
autocmd BufWritePre *.py :%s/\s\+$//e
autocmd BufWritePre *.py :%s#\($\n\s*\)\+\%$##e

function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>

autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTASTIC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%F\ %l\:%c

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8', 'pydocstyle']
let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_typescript_checkers = ['eslint']
let g:javascript_plugin_flow = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf
