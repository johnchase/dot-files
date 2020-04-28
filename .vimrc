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

" Autocomplete and exit brackets"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" This sets clipboard to the previous selection so that you can paste multiple
" times. It is very useful
xnoremap p pgvy

filetype plugin indent on

set colorcolumn=80
set infercase

" Open NERDTree on F2
map <F2> :NERDTreeToggle<CR>

"Show hidden files in NerdTree
let NERDTreeShowHidden=1

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
colorscheme solarized

" PEP8 formatting
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=119 |
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
" Status Line Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
"Set the git branch

set statusline+=%#PmenuSel#
set statusline+=%#LineNr#
set statusline+=%#CursorColumn#
set statusline+=\ %l:%c

set statusline+=\ %f
"set statusline+=%m\
set statusline+=%=
set statusline+=%{StatuslineGit()}
set statusline+=\ %p%%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_w = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8', 'pydocstyle']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['eslint']
let g:javascript_plugin_flow = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Black
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:black_linelength=119
autocmd BufWritePre *.py execute ':Black'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWritePre *.ts execute ':Prettier'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=/usr/local/opt/fzf


"Delete all Git conflict markers
"Creates the command :GremoveConflictMarkers
"If you not using vim fugitive you likely don't need this
function! RemoveConflictMarkers() range
  echom a:firstline.'-'.a:lastline
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
"-range=% default is whole file
command! -range=% GremoveConflictMarkers <line1>,<line2>call RemoveConflictMarkers()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-jsdoc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsdoc_enable_es6 = 1
let g:jsdoc_input_description = 1	
"let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_underscore_private = 1	
