" requires: Vim version 7.4.399 or higher
"
" vim -c ':so %' 'https://raw.githubusercontent.com/magikarp-salesman/from-zero-to-hero/master/download.vim'

function! Setup() abort
	let g:todecode= expand('%:p') . '.enc.sh'
	execute "silent !echo setup file: " . g:todecode
	execute "new"
	execute "r " . g:todecode
	execute "w! setup.sh"
	execute "silent !echo sudo bash setup.sh"
	execute "qa!"
endfunction

call Setup()
