
# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Don't put duplicate lines in the history. See bash(1) for more options.
HISTCONTROL=ignoredups:ignorespace

# Append to the history file, don't overwrite it.
shopt -s histappend

# Use a larger history size.
export HISTSIZE=25000
export HISTFILESIZE=50000

export HISTIGNORE=" *"

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set cursor type to solid vertical bar.
echo -ne '\e[6 q'

# Set the prompt.
function prompt_command() {
    # If working on a python virtualenv, show it in the prompt.
    if [ -n "$VIRTUAL_ENV" ]; then
        local virtualenv="  ($(basename $VIRTUAL_ENV)) "
    else
        local virtualenv=""
    fi

    # If working on a node virtualenv, show it in the prompt.
    if [ -n "$NODE_VIRTUAL_ENV" ]; then
        local nodevirtualenv="  ($(basename $NODE_VIRTUAL_ENV)) "
    else
        local nodevirtualenv=""
    fi

    # If coming in via ssh, show it in the prompt.
    if [ -n "$SSH_CLIENT" ]; then
        local ssh="  (ssh)"
    else
        local ssh=""
    fi

    # Show current git branch in the prompt.
    function find_git_branch {
       local dir=. head
       until [ "$dir" -ef / ]; do
          if [ -f "$dir/.git/HEAD" ]; then
             head=$(< "$dir/.git/HEAD")
             if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch="${head#*/*/}"
             elif [[ $head != '' ]]; then
                git_branch="detached"
             else
                git_branch="unknown"
             fi
             return
          fi
          dir="../$dir"
       done
       git_branch=''
    }
    function find_git_dirty {
        local st=$(git status --untracked-files=no --porcelain 2>/dev/null)
        if [[ $st == "" ]]; then
            git_dirty=''
        else
            git_dirty='*'
        fi
    }
    find_git_branch
    find_git_dirty
    if [ -n "$git_branch" ]; then
        local git="  ($git_branch$git_dirty) "
    else
        local git=""
    fi

    function prompt_left() {
        printf "\
$base01bg$base06\\\\u@\h$base05:$base0D\w/\
$base0E$git\
$base0B$virtualenv\
$base0F$nodevirtualenv\
$base0C$ssh\
$CLEAR_EOL$reset\
"
    }

    # Prompt line with dollar sign.
    # We have to escape color codes so readline can correctly determine line length.
    dollar="\[$base01bg$base0D\]\$\[$reset\]"

    # Assemble the prompt.
    local left=$(prompt_left)
    PS1="${left}\n${dollar} "

    # Write history after every command.
    history -a
}
PROMPT_COMMAND=prompt_command

# Enable git command line completion in bash.
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
fi

## Aliases
alias mv='mv --interactive'
alias cp='cp --interactive'



