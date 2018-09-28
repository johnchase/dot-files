"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" .vimrc
"
" This vim configuration file has bits and pieces taken from the vimrc's of Abe
" Pralle, Bram Moolenaar, and several articles found on the vim wiki (see
" http://vim.wikia.com/wiki/Vim_Tips_Wiki).
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Don't try too hard to be backwards-compatible with "vi".
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

" Keep 50 lines of command line history.
set history=50

" Show the cursor position all the time.
set ruler

" Display incomplete commands.
set showcmd

" Do incremental searching.
set incsearch		

" Don't use Ex mode, use Q for formatting.
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Highlight search matches.
set hlsearch

" Switch syntax highlighting on, when the terminal has colors.
if has("syntax")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  set nocp
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 79 characters.
  autocmd FileType text setlocal textwidth=79

  " We need tabs in makefiles.
  autocmd FileType make setlocal noexpandtab

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  " Map '-' to comment a line, and '_' to uncomment it. This currently works
  " for c, cpp, and vim filetypes by using the appropriate single line comment
  " symbol for the current filetype. Also works in visual and visual block
  " mode to comment blocks of code.
  "filetype on
  augroup vimrc_filetype
   autocmd!
   autocmd FileType c call s:MyCSettings()
   autocmd FileType cpp call s:MyCSettings()
   autocmd FileType vim call s:MyVimSettings()
  augroup end

  " Clear all comment markers (one rule for all languages)
  map _ :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

  function! s:MyCSettings()
    " Insert comments markers
    map - :s/^/\/\//<CR>:nohlsearch<CR>
  endfunction

  function! s:MyVimSettings()
    " Insert comments markers
    map - :s/^/\"/<CR>:nohlsearch<CR>
  endfunction
else " no autocmd
  " always set autoindenting on
  set autoindent
endif

" F1: Toggle hlsearch (highlight search matches).
nmap <F1> :set hls!<CR>

behave xterm
set mousemodel=popup_setpos

" Don't create backup files.
set nobackup 

" When you're doing TAB completion, fix the case of the letters
" you've already typed to match that of the word.
set infercase

" Set the font to 14pt Lucida_Console.
set gfn=Lucida_Console:h14

" Don't start jumping to search matches while you're still typing.
set noincsearch

" Searches for all-lower-case letters match upper-case as well.
set ignorecase

" If your search word contains upper case, match exact case for all
" letters.
set smartcase

" Perform word wrapping.
set linebreak

" Limit the width of text to 79.
set textwidth=79

" Highlight the background in red for text that goes over the
" 79 column limit. The first method of doing so doesn't work
" in gvim when multiple tabs are used.
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.*/

if exists('+colorcolumn')
  set colorcolumn=+1
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>79v.\+', -1)
endif

" Make the tilde (~) an operator instead of a command.  This lets
" you type "~w" to change toggle the case of a word instead of
" just a single letter toggling as soon as you type "~".
set tildeop

" Set the number of spaces used for each manual and auto indent.
set shiftwidth=2

" Mixes actual 8-space TABs and single spaces to get the number of
" spaces you specify here.  For example, hitting [TAB] 3 times would
" give you 6 spaces, 4 times would give you a single TAB, and 5
" times would give you a TAB and 2 spaces.
set softtabstop=2

" Expands any tab characters you type to be the corresponding number 
" of spaces.
set et

" Sets the number of lines the cursor can be from the top or bottom
" of the screen before the screen scrolls to reveal more text.
set scrolloff=3

" Take out default interpretation of octal,hex for ^A (add/increment).
set nrformats=

" Map <F2> to enable pasting from another application without messing
" up the indentation.
set pastetoggle=<F2>

color koehler
hi ColorColumn ctermbg=darkgrey guibg=darkgrey

inoremap  (  ()<Esc>i
inoremap  {  {}<Esc>i
inoremap  [  []<Esc>i
inoremap  '  ''<Esc>i
inoremap  "  ""<Esc>i

inoremap ˙ <Left>
inoremap ∆ <Down>
inoremap ˚ <Up>
inoremap ¬ <Right>

" Set highlighting (colors).
"hi Normal ctermbg=DarkBlue ctermfg=White guibg=DarkBlue guifg=White
"hi Statement ctermbg=DarkBlue ctermfg=Yellow guibg=DarkBlue guifg=Yellow
"hi Identifier ctermbg=DarkBlue ctermfg=LightGreen guibg=DarkBlue guifg=LightGreen
"hi Search ctermbg=DarkBlue ctermfg=White guibg=DarkBlue guifg=White 
"hi PreProc ctermfg=Yellow guifg=Yellow
"hi Constant ctermfg=Green guifg=Green
"hi Comment guifg=Cyan guibg=DarkBlue
"hi Title ctermfg=White guifg=White
"hi ColorColumn ctermbg=darkgrey guibg=darkgrey

" You can use one of these color schemes instead of the above
" (uncomment one of the lines).
"color blue
"color darkblue
"color default
"color delek
"color desert
"color elflord
"color evening
"color koehler
"color morning
"color murphy
"color pablo
"color peachpuff
"color ron
"color shine
"color slate
"color torte
"color zellner

" Set [TAB] to cycle through the auto-complete possibilities of a
" word you're typing.  The possibilities come from other words in
" the current file and other files you're editing.
function! CleverTab()
   if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      return "\<Tab>"
   else
      return "\<C-N>"
endfunction

inoremap <Tab> <C-R>=CleverTab()<CR>

" Set [TAB] to cycle through the auto-complete possibilities of a word you're
" typing.  The possibilities come from omnicomplete, then the dictionary, then
" simple known words. If there is no completion, a tab is inserted.
"function! SuperCleverTab()
"    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
"        return "\<Tab>"
"    else
"        if &omnifunc != ''
"            return "\<C-X>\<C-O>"
"        elseif &dictionary != ''
"            return "\<C-K>"
"        else
"            return "\<C-N>"
"        endif
"    endif
"endfunction
"
"inoremap <Tab> <C-R>=SuperCleverTab()<cr>

" Turn off the options that automatically continue comment lines
" on the next line.  This is good when copying & pasting in Unix;
" you might remove it for use on other systems.
"set formatoptions=t

" No annoying bell!
set visualbell t_vb=

" Show line numbers.
set nu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CODE COMPLETION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set up code completion for C++. Add or remove tags files as needed.
" If you want a new tags file, run the following command to generate one, and
" make sure to add it to this list:
"   ctags -R --sort=1 --c++-kinds=+p --fields=+iaS --extra=+q \
"      --language-force=C++ -f <tag_file_name> <header_path>
"
" Please note that the command above only generates a tags file for C++ code.
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/qt4.6
"set tags+=~/.vim/tags/current_isis
"set tags+=~/.vim/tags/current_project

" The following keymap builds a tags file based on the contents of the current
" directory (it is recursive). vim will automatically load this tags file
" because it always looks in the current directory for a file named 'tags'.
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q -f ~/.vim/tags/current_project .<CR>

" OmniCppComplete configuration.
"let OmniCpp_NamespaceSearch = 1 " Only search namespaces in current buffer.
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1 " Show -, #, or + in popup.
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]

" Allows local var search to work with brace on same line.
"let OmniCpp_LocalSearchDecl = 1

" If completeopt has 'longest' enabled, this will automatically selected the
" string with the longest common text from the list, but won't insert it.
"let OmniCpp_SelectFirstItem = 2

" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" We don't want a preview from ctags.
"set completeopt=menuone,menu,longest,preview
"set completeopt=menuone,menu,longest 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /CODE COMPLETION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Pathogen load
"filetype off

"call pathogen#infect()
"call pathogen#helptags()

"filetype plugin indent on
"syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GVIM SECTION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stuff just for gvim. Avoids the need for a .gvimrc.
if has('gui_running')
  " Make sure that the annoying visual bell stays off (this must be kept
  " separate from ~/.vimrc since GVIM resets some stuff after it reads the vimrc
  " and when it loads the GUI)
  if has("autocmd") && has("gui")
          au GUIEnter * set t_vb=
  endif

  " This makes sure that gvim opens up fully maximized.
  "set lines=999

  " This looks better in gvim.
  set gfn=Bitstream\ Vera\ Sans\ Mono\ 11

  " Tab navigation.
  :map <F2> :tabprevious<CR>
  :map <F3> :tabnext<CR>

  " Rearrange tabs.
  :map <silent> <S-F2> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
  :map <silent> <S-F3> :execute 'silent! tabmove ' . tabpagenr()<CR>
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" /GVIM SECTION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd VimEnter * NERDTree
let NERDTreeShowHidden=1
execute pathogen#infect()
