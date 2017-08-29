" cpp settings "
"

" Compiler
	setlocal makeprg=make\ -j20\ --directory=./build/

" CMake settings
	" Since we're in vi, chances are we want a debug build
	let g:cmake_build_type = 'Debug'

" Enhanced keyboard mappings
	" switch between header/source with F4
	map <buffer> <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
	" recreate tags file with F5
	map <buffer> <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>
	" create doxygen comment
	map <buffer> <F6> :Dox<CR>
	" build using makeprg with <F7>
	map <buffer> <F7> :make<CR>
	" build using makeprg with <S-F7>
	map <buffer> <S-F7> :make clean all<CR>
	" rebuild using cmake
	" Searches up folders until a build folder is found and runs CMake from
	" there
	map <buffer> <F8> :CMake<CR> 
	map <buffer> <S-F8> :CMakeClean<CR> 
	" goto definition with F12 in new vertical split
	map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
	" go back from definition
	
	map <buffer> <F9> :YcmCompleter FixIt<CR>

