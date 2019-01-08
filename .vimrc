""" Get out of vi-compatible mode (I'm not sure what this does)
set nocompatible

let editor_name='vim'
if has('nvim')
  let editor_name='nvim'
endif
let g:plugins_location=expand('~/.vim/plugged')
let gocode_script=g:plugins_location . 'gocode_symlink.sh'

""" run ":PlugInstall" to install everything defined here
""" run ":PlugUpdate" to update all plugins from source
""" See https://github.com/junegunn/vim-plug for more details
call plug#begin()
Plug 'VundleVim/Vundle.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-syntastic/syntastic'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mdempsky/gocode', {'for': 'go', 'rtp': editor_name, 'do': gocode_script } " Go autocompletion
Plug 'godoctor/godoctor.vim', {'for': 'go'} " Gocode refactoring tool
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'
call plug#end()

""" vim is reading the term type from screen, which ain't xterm.
set t_Co=256

""" Turn on coloring
syntax on

""" Language specifid settings
""" autocmd Filetype c      call languagestyles#C()
""" autocmd Filetype go     call languagestyles#Go()
""" autocmd Filetype vim    call languagestyles#Vimscript()
""" autocmd Filetype python call languagestyles#Python()

""" Plugins
filetype plugin on

""" Vim-go set the quickfix window across the entire bottom (otherwise conflicts with tagbar
autocmd FileType qf wincmd J

""" Allow vim to backspace over characters added in previous insert sessions
set backspace=indent,eol,start

""" Turns on line wrapping
set wrap

""" Turns on line numbers
set number

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
""" set foldmethod=syntax
""" set foldmethod=indent
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

""" Focus on windows containing buffers instead of opening them in a new
set switchbuf=useopen

""" Show line and column numbers
set ruler

""" Resize all windows to keep them the same size when splitting
set equalalways

""" Open new splits to the right instead of or left
set splitright

""" Highlights the line containing the cursor
set cursorline

""" Turns off the bell
set vb t_vb=

""" Let's F3 toggle paste mode
set pastetoggle=<F3>

""" Toggle invisible chars
noremap ,i :set list!<CR>

""" Allows one to insert newlines without entering insert mode
map <Enter> o<ESC>

""" Remaps // to search for a selected visual block
vnoremap <expr> // 'y/\V'.escape(@",'\').'<CR>'

""" Cursor Movement - Make cursor move by visual lines instead of file lines (when wrapping)
map <up> gk
map k gk
imap <up> <C-o>gk
map <down> gj
map j gj
imap <down> <C-o>gj
map E ge

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
  let exec_str = 'cd ' . path . ' && ctags --exclude=*git* --exclude=*tox* -R -f ' . path . '/tags ' . path
  let result = system(exec_str)
  echo result
  echo "Generated tags completed. Tags file placed in " . path
endfun

""" Set tag locations. For some reason the semi-colon tells it to recurse up
set tags=~/.ctags/python_std_lib,~/.ctags/python_usr_lib,tags;$HOME

nnoremap <silent> <F2> :call GenCTags()<cr>

""" Opens the tag under the cursor in a vsplit
nnoremap <F4> :vsp <cr>:exec("tag ".expand("<cword>"))<cr>

""" Opens the tag under the cursor in a horizontal split
nnoremap <F5> :split <cr>:exec("tag ".expand("<cword>"))<cr>


""" Just straight up stop F1 from opening the help window
map <F1> <nop>
imap <F1> <nop>

""" Tagbar settings and hacks. This assumes the tagbar is the rightmost split.
""" Obviously this doesn't work if you change the tagbar to be somewhere else

nnoremap <F8> :TagbarToggle<CR>
fun JumpToRightmost()
  let lastwin = winnr("$")
  exe lastwin . " " . "wincmd w"
endfun

nnoremap <F9> :call JumpToRightmost()<CR>


""" Mapping for the tags list plugin. You need exuberant ctags installed for
""" this one!
nnoremap ,tl :TlistToggle<CR>

""" Profiling shortcuts
nnoremap <leader>DD :exe ":profile start profile.log"<cr>:exe ":profile func *"<cr>:exe ":profile file *"<cr>
nnoremap <leader>DP :exe ":profile pause"<cr>
nnoremap <leader>DC :exe ":profile continue"<cr>
nnoremap <leader>DQ :exe ":profile pause"<cr>:noautocmd qall!<cr>

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" OR ELSE just highlight the match in red...
function! HLNext (blinktime)
    highlight WhiteOnRed ctermfg=white ctermbg=red
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#\%('.@/.'\)'
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

""" ====[ Swap : and ; to make colon commands easier to type ]======
nnoremap  ;  :
nnoremap  :  ;

""" Go plugin shortcuts
autocmd FileType go nmap <leader>gc  <Plug>(go-callees)
autocmd FileType go nmap <leader>gi  <Plug>(go-implements)

""" Filetype specifics
colorscheme onedark


""" Highlight extra whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

""" NOTE: This is what highlights after column 80, if enabled
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
function! Tabstyle_PEP8()
  """ Turns on a highlight column at column 80.
  """ set colorcolumn=80
  """ ====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======
  set list
  let w:m1=matchadd('LineProximity', '\%<121v.\%>120v', -1)
  let w:m2=matchadd('LineOverflow', '\%>120v.\+', -1)
  highlight ColorColumn ctermbg=magenta
  call matchadd('ColorColumn', '\%81v', 100)
endfunction



""" Add a couple things if the filetype is Python
autocmd Filetype python call Tabstyle_PEP8()

""" Never use tabs
""" I think this setting is breaking pasting into Vim, resetting spaces back to tabs
""" set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
"
""" When deleting a softtab, delete a shiftwidth number of spaces
set smarttab

""" Show file path and coords
set statusline=%1*%f%*(%04l,%04v,%P/%L)%y
set laststatus=2

""" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}

""" Add current tag to statusline
set statusline+=%{tagbar#currenttag('[%s]\ ','')}

set statusline+=%*


"""let g:syntastic_python_checker_args='--builtins=_'
"""let g:syntastic_always_populate_loc_list = 0
"""let g:syntastic_auto_loc_list = 0
"""let g:syntastic_check_on_open = 1
"""let g:syntastic_check_on_wq = 0
"""let g:syntastic_auto_jump = 0
"""let g:syntastic_ignore_files = ['\m^/usr/include/', '\m\c\.h$', '.tox/', '.pip/', '.venv']

hi link LineProximity FoldColumn
hi link LineOverflow Special

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

""" Airline config
let g:airline_powerline_fonts = 1
let g:airline_theme="luna_alt"
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#formatter = "default"

""" Enable deoplete autocompletion
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 2

""" Deoplete-go settings
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

""-go settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
""" Sets the "old" syntax highlighting engine for vim-go: https://github.com/fatih/vim-go/issues/72
set re=1

""" Vim-go settings
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

""" Neovim specific settings
""" if has("nvim")
"""     " True color support
"""     set termguicolors
""" endif
if exists('+undofile')
    " undofile -- This allows you to use undos after exiting and
    "             restarting. NOTE: only present in 7.3+
    "             :help undo-persistence
    if isdirectory( $HOME . '/.vim/.undo' ) == 0
        :silent !mkdir -m 700 -p ~/.vim/.undo > /dev/null 2>&1
    endif
    set undodir=~/.vim/.undo
    set undofile
endif

" Restore cursor to file position in previous editing session
function! ResCur()
if line("'\"") <= line("$")
    silent! normal! g`"
    return 1
endif
endfunction


augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END


let g:rainbow_active = 1
