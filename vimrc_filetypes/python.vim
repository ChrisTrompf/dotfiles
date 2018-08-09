
" Basic
	setlocal colorcolumn=80	" Highlight 80th column to match style guide

" Tab stuffs	
	setlocal tabstop=4      " tab width is 4 spaces
	setlocal shiftwidth=4   " indent also with 4 spaces
	setlocal expandtab     	" expand tabs to spaces as per style guide
	setlocal ruler
	setlocal autoindent

	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	" Show trailing whitespace and spaces before a tab:
	:match ExtraWhitespace / \s\+$\| \+\ze\t/
