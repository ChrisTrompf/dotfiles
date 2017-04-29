# dotfiles
My default linux dotfiles. Allowing me to initialise a box with minimal effort. These configs (at least initially) are
designed to work on systems with as few assumptions as possible. That means that no vim plugins are assumed to be
installed.

## Installing
Checkout these configs is as simple as cloning this project and running 'install.sh'. Symlinks will be created to the
projects directory. This means that if the project is updated, the config files will be automatically updated too.

	install.sh [skip|force]

skip indicates that existing dotfiles should remain unchanged, where force will remove any existing files before
creating the symlink.

## Vim
- line and relative numbers
- smartcase search ('abc' is case insensitive, but 'Abc' is case sensitive)
- Search matches are highlighted
- Syntax highlighting
- 256 color
- Search into sub-folders with tab completion
- Display all options when using tab completion
- Disable arrow keys to force hjkl use
- File explorer enabled
- Tag jumping
- Map Fx keys to build, saving, etc

## tmux
- replace ctl-b binding with ctl-a
- Resize pane with hjkl
- switch panes with arrow keys
- Switch panes with alt-hjkl
- prev/next window with shift-left/right arrow


