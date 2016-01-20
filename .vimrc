""" Make sure vundle is being used
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
call vundle#end()

""" Get out of vi-compatible mode (I'm not sure what this does)
set nocompatible

""" vim is reading the term type from screen, which ain't xterm.
set t_Co=256

""" Enable Pathogen
call pathogen#infect()

""" Turn on coloring
syntax on

""" Allow vim to backspace over characters added in previous insert sessions
set backspace=indent,eol,start

""" Don't use real tabs!!!
set expandtab
set shiftwidth=2
set tabstop=2

""" Turns on line wrapping
set wrap

""" Threshold for reporting the number of lines changed. Setting it to 0
""" always reports number of lines changed
set report=0

""" Ensure the cursor stay away from the edges of the screen, scrolling the
""" screen instead
set scrolloff=2
set sidescrolloff=2

""" Minimum number of columns to use when line numbers are turned on
set numberwidth=4

""" Maintain tab spacing (If I've pressed space 3 times and use >,
""" move 1 space, not 2)
set shiftround

""" Code folding
set foldenable
set foldmarker={,}
set foldmethod=marker " Fold on the marker
set foldlevel=100 " Don't automatically fold
set foldopen=block,hor,mark,percent,quickfix,tag " what movements

""" Swap File location
set directory=~/.vim/swap

""" Set backup dir and enable
set backupdir=~/.vim/backups
set backup

"" Guess indentation level (when pasting text use :set pastemode)
set autoindent
set smartindent

""" Highlight the tokens that match the search
set hlsearch

""" Change the leader key to ,
let mapleader = ","

""" Start searching after each typed character
set incsearch

""" Ignore the case of the search term when all lowercase
set ignorecase

""" Present a menu of matching files when using wildcard completion
set wildmenu
set wildmode=list:longest,full

""" File patterns to ignore
set wildignore=*.pyc

""" highlights the opposing paren/bracket when highlighting a paren/bracket
set showmatch

""" Show line and column numbers
set ruler

""" Resize all windows to keep them the same size when splitting
set equalalways

""" When deleting a softtab, delete a shiftwidth number of spaces
set smarttab

""" Highlights the line containing the cursor
set cursorline

""" Turns off the bell
set vb t_vb=

""" Invisible character display
set listchars=trail:.,tab:>-,eol:$
set nolist

""" Toggle invisible chars
noremap ,i :set list!<CR>

""" Reload/edit vimrc easily
map ,rv :so ~/.vimrc<CR>
map ,ev :new ~/.vimrc<CR>

""" Handy git commands
map ,gs :!git status<CR>
""" git-diff current file
map ,gdc :!git diff --color %<CR>
""" git-diff entire tree
map ,gda :!git diff --color<CR>
map ,gb :!git blame %<CR>
map ,gr :!git grep "

""" Quickly change between 2 and 4 spaces
map ,sw2 :set ts=2 sw=2<CR>
map ,sw4 :set ts=4 sw=4<CR>

""" Run ruby syntax checker
map ,cr :!ruby -c %<CR>

""" Run pep8 checker
map ,rp8 :!pep8 --repeat %<CR>

""" Allows one to insert newlines without entering insert mode
map <Enter> o<ESC>

""" Shortcut for NERDTree
:noremap ,n :NERDTreeToggle<CR>

""" Cursor Movement - Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge

if has("cscope")
    set csprg=~/bin/cscope
    set csto=0
    set cst
    set nocsverb
    " add any database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
        " else add database pointed to by environment
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endif

""" Turns on line highlighting for the current cursor location but ensures it's only highlighted in the focused buffer
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

""" Borrowed and adapted from github.com/tr3buchet
fun GenPythonCTags()
  let result = system('ctags -R -f ~/.ctags/python_usr_lib /usr/local/lib/python2.7')
  let result = system('ctags -R -f ~/.ctags/python_std_lib /usr/lib/python2.7')
  echo "Finished generating python ctags"
endfun

fun GenCTags()
  let path = system('git rev-parse --show-toplevel | tr -d "\n"')
  if v:shell_error
    echo "not a git or bzr repo"
    return 0
  endif
  let result = system('ctags --exclude=*git* --exclude=*tox* -R -f ' . path . '/tags ' . path)
  echo "Generated tags completed. Tags file placed in " . path
endfun

""" Set tag locations. For some reason the semi-colon tells it to recurse up
set tags=~/.ctags/python_std_lib,~/.ctags/python_usr_lib,tags;$HOME

nnoremap <silent> <F2> :call GenCTags()<cr>

""" Opens the tag under the cursor in a vsplit
nnoremap <F4> :vsp <cr>:exec("tag ".expand("<cword>"))<cr>

""" Opens the tag under the cursor in a horizontal split
nnoremap <F5> :split <cr>:exec("tag ".expand("<cword>"))<cr>

""" Mapping for the tags list plugin. You need exuberant ctags installed for
""" this one!
nnoremap ,tl :TlistToggle<CR>

""" Profiling shortcuts
nnoremap <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <leader>DP :exe ":profile pause"<cr>
nnoremap <leader>DC :exe ":profile continue"<cr>
nnoremap <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>

au BufRead, BufNewFile *.rb, *.rhtml set shiftwidth=2
au BufRead, BufNewFile *.rb, *.rhtml set softtabstop=2

au BufRead, BufNewFile *.py set shiftwidth=4
au BufRead, BufNewFile *.py set softtabstop=4

""" Filetype specifics
colorscheme ir_black

""" Plugins
filetype plugin on

""" Highlight extra whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

function! Tabstyle_PEP8()
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set expandtab
  """ All I really want is the highlighting, not the obnoxious red line
  """ set colorcolumn=80

  let w:m1=matchadd('LineProximity', '\%<121v.\%>80v', -1)
  let w:m2=matchadd('LineOverflow', '\%>120v.\+', -1)
endfunction

function! Tabstyle_Glob()
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
  set expandtab
  let w:m1=matchadd('LineProximity', '\%<121v.\%>80v', -1)
  let w:m2=matchadd('LineOverflow', '\%>120v.\+', -1)
endfunction

autocmd FileType * call Tabstyle_Glob()
autocmd Filetype python call Tabstyle_PEP8()

""" Omni Completion
autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd BufRead FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

""" Show file path and coords
set statusline=%1*%f%*(%04l,%04v,%P/%L)%y
set laststatus=2

""" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_python_checker_args='--builtins=_'
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 0
let g:syntastic_ignore_files = ['\m^/usr/include/', '\m\c\.h$', '.tox/', '.pip/', '.venv']

hi link LineProximity FoldColumn
hi link LineOverflow Special

""" Neocomplete config
""" This is really slow. Need to decide how I feel about this
""" This requires vim with lua installed:
""" On mac: brew install vim --with-lua
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

""" Airline config
let g:airline_powerline_fonts = 1
let g:airline_theme="luna"
let g:airline#extensions#syntastic#enabled = 0
