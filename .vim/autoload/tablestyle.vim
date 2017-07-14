" -----------------------------------------------------------------------------
" |                            TABStyle Settings 			      |
" |                                                                           |
" | call tabstyle#Tabstyle("Tabs", <width>) for Tabs                          |
" | call tabstyle#Tabstyle("Spaces", <width>) for Tabs                        |
" |                                                                           |
" -----------------------------------------------------------------------------


function! tabstyle#Tabstyle(name, width)
	let l:Current = function("tabstyle#".a:name)
	return l:Current(a:width)
endfunction

function! tabstyle#Spacing(width)
	let &softtabstop=a:width
	let &shiftwidth=a:width
	let &tabstop=a:width
endfunction


function! tabstyle#Tabs(width)
	call tabstyle#Spacing(a:width)
	set noexpandtab
endfunction

function! tabstyle#Spaces(width)
	call tabstyle#Spacing(a:width)
	set expandtab
endfunction
