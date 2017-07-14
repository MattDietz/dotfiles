" Wrapping and tabs.
"set textwidth=78        " (tw) number of columns before an automatic line break is inserted (see formatoptions)
"set tabstop=4           " (ts) width (in spaces) that a <tab> is displayed as
set shiftwidth=4        " (sw) width (in spaces) used in each step of autoindent (aswell as << and >>)
"set smarttab            " (sta) 'shiftwidth' used in front of a line, but 'tabstop' used otherwise
set expandtab           " (et) converts tabs to spaces
set softtabstop=4       " (sts) amount of spaces to insert with tab keypress
set autoindent          " (ai) turn on auto-indenting

" More syntax highlighting.
let python_highlight_all = 1

" Smart indenting
"set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Show long lines.
highlight LongLine guibg=red ctermbg=red
match LongLine /\%>79v.\+/
