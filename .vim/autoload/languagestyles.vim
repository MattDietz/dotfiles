" -----------------------------------------------------------------------------
" |                            languagestyles Settings                               |
" |                                                                           |
" | autocmd Filetype c call languagestyles#C()                                |
" | autocmd Filetype go call languagestyles#Go()                              |
" | autocmd Filetype python call languagestyles#Python()                      |
" | autocmd Filetype vim call languagestyles#Vimscript()                      |
" |                                                                           |
" -----------------------------------------------------------------------------

function! languagestyles#C()
    call tabstyle#Tabstyle("Tabs", 8)
    call colorcolumn#ColorColumn(80, 8)
endfunction

function! languagestyles#Go()
    call tabstyle#Tabstyle("Tabs", 4)
    call colorcolumn#ColorColumn(120, 40)
endfunction

function! languagestyles#Python()
    call tabstyle#Tabstyle("Spaces", 4)
    call colorcolumn#ColorColumn(120, 40)
endfunction

function! languagestyles#Vimscript()
    call tabstyle#Tabstyle("Spaces", 2)
    call colorcolumn#ColorColumn(80, 8)
endfunction
