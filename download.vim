" requires: Vim version 7.4.399 or higher
"
" vim -c ':so %' 'https://raw.githubusercontent.com/magikarp-salesman/from-zero-to-hero/master/download.vim'

function! Setup() abort
	let g:todecode = expand('%:p') . '.enc.sh'
	execute "silent !echo setup file: " . g:todecode
	execute "silent !echo sudo bash setup.sh"
	execute "new"
	execute "Nread \"" . g:todecode . "\""
	execute "write! setup.sh"
	execute "quitall!"
endfunction

call Setup()
