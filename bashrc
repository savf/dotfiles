# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

############################################################################
# ALIASES                                                                  #
############################################################################

if [ -f "$HOME/.aliases" ]; then
. "$HOME/.aliases"
fi

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'
alias necksafe="source ~/.bin/alwaysontop.sh"
alias howmuch="du -hs"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

############################################################################
# EXPORTS                                                                  #
############################################################################

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export VISUAL=vim
export EDITOR="$VISUAL"
export PIP_REQUIRE_VIRTUALENV=false

############################################################################
# HISTORY                                                                  #
############################################################################

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

############################################################################
# 3RD PARTY                                                                #
############################################################################

# Automatically adapt bash to window size
shopt -s checkwinsize

# Make less more friendly for non-text input files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

gpip(){
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

if [ -f /usr/share/autojump/autojump.sh ]; then
	. /usr/share/autojump/autojump.sh
fi
if [ -f /usr/local/bin/brew ]; then
  [[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
fi

############################################################################
# PROMPT                                                                   #
############################################################################

PROMPT_COMMAND='pwd2=$(sed "s:\([^/]\)[^/]*/:\1/:g" <<<$PWD)'
PS1='\[\e[01;30m\]\t \[\e[1;49;35m\]\u@\h \[\e[00;34m\]$pwd2 \[\e[00m\]\$ '
