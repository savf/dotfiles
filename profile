if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# add system-specific aliases
if [ -f "$HOME/.aliases" ]; then
. "$HOME/.aliases"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export VISUAL=vim
export EDITOR="$VISUAL"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export HISTTIMEFORMAT="%d.%m.%y %T "
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

PROMPT_COMMAND='pwd2=$(sed "s:\([^/]\)[^/]*/:\1/:g" <<<$PWD)'
PS1='\[\e[01;30m\]\A \[\e[1;49;35m\]\h \[\e[01;34m\]$pwd2 \[\e[00m\]\$ '

alias necksafe="source ~/.bin/alwaysontop.sh"
alias howmuch="du -hs"
