" vimrc file for all projects "
" Can be overridden in ftplugin for specific file types

" Basic
	set nocompatible
	set number					" Show line number
	set relativenumber	" Number of lines above and below current position
	set showmatch			 " Show matching braces
	set colorcolumn=80	" Highlight 80 column. I know 80 isn't much, but makes side by side on laptops much nicer
	set cursorline			" Highlight the line the cursor is on

	" Searching
	set ignorecase			" Default to case insensitive searching, smartcase will this when searching for a string containing up-case
	set smartcase			 " Insensitive search unless there is an upper 
	set hlsearch				" Highlight search matches
	set incsearch			 " Show matching searches as you type
	" Disable the highlighting of the current search. Next search will be
	" highlighted
	nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

	" set UTF-8 encoding
	set enc=utf-8
	set fenc=utf-8
	set termencoding=utf-8

" Tab stuffs
	set tabstop=2				" tab width is 2 spaces
	set shiftwidth=2		 " indent also with 2 spaces
	set noexpandtab			" use tabs
	set ruler
	set autoindent

" Show special characters
	set list
	set listchars=eol:¬,tab:\ \ ,precedes:«,extends:»,trail:·

	" Enable syntax and plugins
	syntax enable

" Whitespace
	" Ensure color scheme doesn't overwrite white space highlighting
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	" Show trailing whitespace, spaces before a tab or spaces used for indenting
	match ExtraWhitespace / \s\+$\| \+\ze\t\|^\t*\zs \+/

" Make relative numbers turn on and off as the window leaves focus or when in
" insert mode
	:augroup numbertoggle
	:	autocmd!
	:	autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
	:	autocmd BufLeave,FocusLost,InsertEnter	 * set norelativenumber
	:augroup END

" Vundle stuffs - https://github.com/VundleVim/Vundle.vim
	filetype off
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" The following are examples of different formats supported.
	" Keep Plugin commands between vundle#begin/end.
	" plugin on GitHub repo
	Plugin 'tpope/vim-fugitive'
	" plugin from http://vim-scripts.org/vim/scripts.html
	" Plugin 'L9'
	" Git plugin not hosted on GitHub
	" Plugin 'git://git.wincent.com/command-t.git'
	" git repos on your local machine (i.e. when working on your own plugin)
	" Plugin 'file:///home/gmarik/path/to/plugin'
	" The sparkup vim script is in a subdirectory of this repo called vim.
	" Pass the path to set the runtimepath properly.
	Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
	" Install L9 and avoid a Naming conflict if you've already installed a
	" different version somewhere else.
	Plugin 'ascenator/L9', {'name': 'newL9'}
	Plugin 'ervandew/supertab'	" Allow YouCompleteMe and ultisnips to share tab
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'mattn/calendar-vim'
	Plugin 'vimwiki/vimwiki'
	Plugin 'scrooloose/nerdtree'
	Plugin 'SirVer/ultisnips'
	Plugin 'honza/vim-snippets'
	Plugin 'altercation/solarized'
	Plugin 'dhruvasagar/vim-table-mode'
	Plugin 'tpope/vim-surround'
	Plugin 'michaeljsmith/vim-indent-object'
	Plugin 'vim-scripts/argtextobj.vim'
	Plugin 'airblade/vim-gitgutter'

	" make YCM compatible with UltiSnips (using supertab)
	let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
	let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
	let g:SuperTabDefaultCompletionType = '<C-n>'
	
	" " better key bindings for UltiSnipsExpandTrigger
	let g:UltiSnipsExpandTrigger = "<tab>"
	let g:UltiSnipsJumpForwardTrigger = "<tab>"
	let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

	" Use markdown format for tables
	let g:table_mode_corner='|'

	" Show git status in nerdtree 
	Plugin 'Xuyuanp/nerdtree-git-plugin'

	" Support CMake
	Plugin 'vhdirk/vim-cmake'

	" All of your Plugins must be added before the following line
	call vundle#end()						" required
	filetype plugin indent on		" required


" Nerdtree
	" Make nerdtree open automatically if no file is specified
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

	" Open nerd tree 
	nnoremap <Leader>f :NERDTreeToggle<Enter>

	" Close nerd tree when opening a file
	let NERDTreeQuitOnOpen = 1

	" Automatically close nerd tree if it's the last remaining window
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimwiki
	let g:vimwiki_list = [
		\{'path': '~/docs/vimwiki/personal.wiki', 'path_html': '~/docs/vimwiki/personal.html', 'syntax' : 'markdown', 'ext' : '.md', 'custom_wiki2html' : '~/bin/md2html.py' },
		\{'path': '~/docs/vimwiki/programming.wiki', 'path_html': '~/docs/vimwiki/programming.html', 'syntax' : 'markdown', 'ext' : '.md', 'custom_wiki2html' : '~/bin/md2html.py' },
		\{'path': '~/docs/vimwiki/linux.wiki', 'path_html': '~/docs/vimwiki/linux.html', 'syntax' : 'markdown', 'ext' : '.md', 'custom_wiki2html' : '~/bin/md2html.py' }
		\]

" Color scheme
	set t_Co=256
	colorscheme torte
	let g:solarized_termcolors=256
	colorscheme solarized

" Finding files
	" Search into sub-folders with tab completion
	set path+=**

	" Display all matching files when we tab complete
	set wildmenu

" Disable arrow keys to force myself to use hjkl
	" Disable Arrow keys in Escape mode
	map <up> <nop>
	map <down> <nop>
	map <left> <nop>
	map <right> <nop>

	" " Disable Arrow keys in Insert mode
	imap <up> <nop>
	imap <down> <nop>
	imap <left> <nop>
	imap <right> <nop>

" Setup folding
	set foldmethod=syntax
	set foldlevelstart=1
	set foldnestmax=20
	" Automatically close folds as you leave
	set foldclose=all
	set foldenable

" *** Tag jumping ***
" ^] to jump to a tag
" g^] to jump to ambiguous
" ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Windows resize
	nnoremap <C-w>M <C-w>\|<C-w>_
	nnoremap <C-w>m <C-w>=

" Enhanced keyboard mappings *** 
	" in normal mode F2 will save the file
	map <F2> :w<CR>
	" in insert mode F2 will exit insert, save, enters insert again
	map <F2> <ESC>:w<CR>i

" in diff mode we use the spell check keys for merging
if &diff
	” diff settings
	map <M-Down> ]c
	map <M-Up> [c
	map <M-Left> do
	map <M-Right> dp
	map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
else
	" spell settings
	:setlocal spell spelllang=en
	" set the spellfile - folders must exist
	set spellfile=~/.vim/spellfile.add
	map <M-Down> ]s
	map <M-Up> [s
endif

" Allow for local override if vi is started from the project root
	silent! source .vimlocal

