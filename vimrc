" vimrc file for all projects "
" Can be overridden in ftplugin for specific file types

" Basic
	set nocompatible
	set number					" Show line number
	set relativenumber	" Number of lines above and below current position
	set showmatch				" Show matching braces
	set colorcolumn=80	" Highlight 80 column. I know 80 isn't much, but makes side by side on laptops much nicer
	set cursorline			" Highlight the line the cursor is on
	set scrolloff=5			" Ensure there is always 5 lines above or below cursor position and rather than
											" have cursor at the edge of the window
	set nowrap					" Don't wrap text

" Mouse support
	set mouse=a

	" Searching
	set ignorecase			" Default to case insensitive searching, smartcase will this when searching for a string containing up-case
	set smartcase			 " Insensitive search unless there is an upper 
	set hlsearch				" Highlight search matches
	set incsearch			 " Show matching searches as you type
	" Disable the highlighting of the current search. Next search will be
	" highlighted
nnoremap <silent> <Space>/ :nohlsearch<Bar>:echo<CR>

	" set UTF-8 encoding
	set enc=utf-8
	set fenc=utf-8
	set termencoding=utf-8

" Tab stuffs
	set tabstop=2				" tab width is 2 spaces
	set shiftwidth=0		" Use tabstop value
	set noexpandtab			" use tabs
	set ruler
	set autoindent

" Show special characters
	set list
	set listchars=eol:¬,tab:\|\ ,precedes:«,extends:»,trail:·

	" Enable syntax and plugins
	syntax enable

" Whitespace
	" Ensure color scheme doesn't overwrite white space highlighting
	autocmd ColorScheme * highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
	" Show trailing whitespace, spaces before a tab or spaces used for indenting
	" match ExtraWhitespace / \s\+$\| \+\ze\t/
	match ExtraWhitespace / \s\+$\|\t\+$/
	" match ExtraWhitespace / \s\+$\| \+\ze\t\|^\t*\zs \+/

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
	" Handle git branches by calling :Twiggy
	Plugin 'sodapopcan/vim-twiggy'
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
	" Plugin 'Valloric/YouCompleteMe'
	Plugin 'neoclide/coc.nvim', {'branch': 'release'}
	Plugin 'mattn/calendar-vim'
	Plugin 'vimwiki/vimwiki'
	Plugin 'scrooloose/nerdtree'
	Plugin 'SirVer/ultisnips'
	Plugin 'honza/vim-snippets'
	Plugin 'altercation/vim-colors-solarized'
	Plugin 'dhruvasagar/vim-table-mode'
	Plugin 'tpope/vim-surround'

	" Select using indent. vii current indent, vaI selects line above and
	" below too
	Plugin 'michaeljsmith/vim-indent-object'
	Plugin 'vim-scripts/argtextobj.vim'
	Plugin 'airblade/vim-gitgutter'

	" Add support for plantuml-syntax
	Plugin 'aklt/plantuml-syntax'

	" Add support for showing tags on a bar using :TagbarToggle
	Plugin 'majutsushi/tagbar'

	" Syntax highlighting for Cap'n'Proto files
	Plugin 'cstrahan/vim-capnp'

	" Allow <C-A> and <C-X> to inc/dec dates and times
	Plugin 'tpope/vim-speeddating'
	" gA shows the dec, hex, oct and bin values of the number under the cursor
	" crd, crx, cro, crb to convert
	Plugin 'glts/vim-radical'

	" Allow for large number support, used by other plugins such as radical
	Plugin 'glts/vim-magnum'
	" Allow for exploring open buffers using '<leader>be' command
	Plugin 'jlanzarotta/bufexplorer'
	" Pretty ruler
	Plugin 'vim-airline/vim-airline'
	Plugin 'vim-airline/vim-airline-themes'

	" Allow for quick jumping using <leader><leader><motion>
	Plugin 'easymotion/vim-easymotion'

	" fzf for fuzzy searching
	Plugin 'junegunn/fzf'

	" Ripgrep
	Plugin 'BurntSushi/ripgrep'
	" Silver searcher
	Plugin 'ggreer/the_silver_searcher'
	" rainbow brackets
	Plugin 'junegunn/rainbow_parentheses.vim'

	" Change autocomplete from <C-y> to <tab>
	" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
	" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
	let g:SuperTabDefaultCompletionType = "context"
 
" COC
	" Use <c-space> to trigger completion
	if has('nvim')
		inoremap <silent><expr> <c-space> coc#refresh()
	else
		inoremap <silent><expr> <c-@> coc#refresh()
	endif

	" Use tab for trigger completion with characters ahead and navigate
	" NOTE: There's always complete item selected by default, you may want to enable
	" no select by `"suggest.noselect": true` in your configuration file
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config
	inoremap <silent><expr> <TAB>
				\ coc#pum#visible() ? coc#pum#next(1) :
				\ CheckBackspace() ? "\<Tab>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

	" Make <CR> to accept selected completion item or notify coc.nvim to format
	" <C-g>u breaks current undo, please make your own choice
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
																\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

	function! CheckBackspace() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	" Use `[g` and `]g` to navigate diagnostics
	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)

	" GoTo code navigation
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)

	" Use K to show documentation in preview window
	nnoremap <silent> K :call ShowDocumentation()<CR>

	" Highlight the symbol and its references when holding the cursor
	autocmd CursorHold * silent call CocActionAsync('highlight')

	" Symbol renaming
	nmap <leader>rn <Plug>(coc-rename)
	
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

" Tagbar
	" Toggle tagbar
	noremap <space>t :TagbarOpen fj<Enter>

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
	" map <up> <nop>
	" map <down> <nop>
	" map <left> <nop>
	" map <right> <nop>

	" " Disable Arrow keys in Insert mode
	" imap <up> <nop>
	" imap <down> <nop>
	" imap <left> <nop>
	" imap <right> <nop>

" Setup folding
	set foldmethod=syntax
	set foldlevelstart=2
	set foldnestmax=20
	" Automatically close folds as you leave
	" set foldclose=all
	set foldclose=
	set foldenable
	set foldcolumn=2
	nnoremap <silent> <Space> za


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
	nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<cr>
	nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<cr>
	nnoremap <silent> <M-+> :exe "resize " . (winwidth(0) * 3/2)<cr>
	nnoremap <silent> <M--> :exe "resize " . (winwidth(0) * 2/3)<cr>

" Ensure sensible sizes
	set winheight=30
	set winminheight=5

" Moving around windows
	nnoremap <C-h> <C-w>h
	nnoremap <C-j> <C-w>j
	nnoremap <C-k> <C-w>k
	nnoremap <C-l> <C-w>l

" Enhanced keyboard mappings ***
	" in normal mode F2 will save the file
	map <F2> :w<CR>
	" in insert mode F2 will exit insert, save, enters insert again
	map <F2> <ESC>:w<CR>i

" Open FZF file search
	nnoremap <space>f :FZF<CR>

" Open buffers list
	nnoremap <space>b :BufExplorer<CR>

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

" Other files types
" 	" Highlight template implementations as c++ files
 		autocmd BufEnter *.tpp :setlocal filetype=cpp

" Allow for local override if vi is started from the project root
	silent! source .vimlocal

