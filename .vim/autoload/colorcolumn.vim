" -----------------------------------------------------------------------------
" |                            colorcolumn Settings 			      |
" |                                                                           |
" | call colorcolumn#ColorColumn(80, 8)                                       |
" |	for a column at 80 characters with a proximity warning at 72 chars    |
" | call colorcolumn#ColorColumn(120, 40)                                     |
" |	for a column at 120 characters with a proximity warning at 80 chars   |
" -----------------------------------------------------------------------------
"

hi link LineProximity FoldColumn
hi link LineOverflow Special

function! colorcolumn#ColorColumn(width, proximitywarning)
	let over = a:width+1
	let proximity = a:width - a:proximitywarning

	let &colorcolumn=a:width

	let w:m1=matchadd('LineProximity', '\%<' . over . 'v.\%>' . proximity . 'v', -1)
	let w:m2=matchadd('LineOverflow', '\%>' . a:width . 'v.\+', -1)
endfunction
