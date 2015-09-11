# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

PROMPT_COMMAND='pwd2=$(sed "s:\([^/]\)[^/]*/:\1/:g" <<<$PWD)'
PS1='\[\e[01;30m\]\A \[\e[1;49;35m\]\h \[\e[01;34m\]$pwd2 \[\e[00m\]\$ '

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export VISUAL=vim
export EDITOR="$VISUAL"
alias necksafe="source ~/.bin/alwaysontop.sh"
alias howmuch="du -hs"
