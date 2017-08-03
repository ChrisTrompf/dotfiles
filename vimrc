
" *** Basic ***
set nocompatible
set number
set relativenumber
set smartcase

" Tab stuffs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set noexpandtab      " expand tabs to spaces
set ruler

" use indentation of previous line
set autoindent

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" highlight matching braces
set showmatch

" Enable syntax and plugins
syntax enable

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
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'Valloric/YouCompleteMe'
Plugin 'vimwiki/vimwiki'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Color scheme
set t_Co=256
colorscheme peachpuff

" Make from build path
set makeprg=make\ -j20\ --directory=./build/

" *** Finding files ***

" Search into sub-folders with tab completion
set path+=**

" Display all matching files when we tab complete
set wildmenu


" *** Disable arrow keys ***
" Disable arrow keys to force myself to use hjkl
"
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

" *** Tag jumping ***
" ^] to jump to a tag
" g^] to jump to ambiguous
" ^t to jump back up the tag stack
command! MakeTags !ctags -R .

" *** Auto complete ***
" Highlights
" - ^n for anything specified by the 'complete' option (^n and ^p move up and down the list)
" - ^x^n for just this file
" - ^x^f for filename
" - ^x^] for tags only


" *** File Browsing ***
filetype plugin on

let g:netrw_banner=0		" Remove banner
let g:netrw_browse_split=4	" Open in prior window
let g:netrw_altv=1			" Open splits to the right
let g:netrw_liststyle=3		" Tree view
" let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" Mapping q to close netrw is easily solved
autocmd FileType netrw nnoremap q :bd<CR>
" Open up explorer window to be 25% 
let g:netrw_winsize = 25
" Netrw behave like nerdtree
augroup ProjectDrawer
  autocmd!
    autocmd VimEnter * :Vexplore
augroup END

" :edit a folder to open a file browser
" <CR>/v/t To open in h-split/v-split/tab

" wrap lines at 120 chars. 80 is somewhat antiquated with nowadays displays.
set colorcolumn=120
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */

" Install OmniCppComplete like described on http://vim.wikia.com/wiki/C++_code_completion
" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
" Load standard tag files

" *** Enhanced keyboard mappings *** 
"
" in normal mode F2 will save the file
map <F2> :w<CR>
" in insert mode F2 will exit insert, save, enters insert again
map <F2> <ESC>:w<CR>i
" switch between header/source with F4
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
" create doxygen comment
map <F6> :Dox<CR>
" build using makeprg with <F7>
map <F7> :make<CR>
" build using makeprg with <S-F7>
map <S-F7> :make clean all<CR>
" goto definition with F12
map <F12> <C-]>
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

