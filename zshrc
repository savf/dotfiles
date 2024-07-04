# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:~/.bin:~/.local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Bash and Zsh
# if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
##### WHAT YOU WANT TO DISABLE FOR WARP - BELOW

#  ZSH_THEME="powerlevel10k/powerlevel10k"

##### WHAT YOU WANT TO DISABLE FOR WARP - ABOVE
# else
  
  eval "$(starship init zsh)"

# fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Kubectx/kubens autocompletion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl-autocomplete)

source $ZSH/oh-my-zsh.sh

# ZSH autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# User configuration

. $(brew --prefix)/opt/asdf/libexec/asdf.sh
export K8S_DEV_NAMESPACE='savf'
export SLACK_USER_EMAIL='stephan.mannhart@starmind.com'
export ANSIBLE_TIMEOUT=120
export do='--dry-run=client -o yaml'
export now='--force --grace-period 0'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

zstyle ':completion:*:ssh:*' hosts
compdef mosh=ssh

# User functions

function k_node_memory_usage {
  local pods=()
  for namespace pod in $(kubectl get po -A -owide | grep $1 | awk '{print $1, $2}');
  do
    pods+=($(kubectl top pod --no-headers -n $namespace $pod 2> /dev/null))
  done;
  printf '%s %s %s\n' $pods | sort --key 3 -nr | column -t
}

function k_node_cpu_usage {
  local pods=()
  for namespace pod in $(kubectl get po -A -owide | grep $1 | awk '{print $1, $2}');
  do
    pods+=($(kubectl top pod --no-headers -n $namespace $pod 2> /dev/null))
  done;
  printf '%s %s %s\n' $pods | sort --key 2 -nr | column -t
}

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
[ -f ~/.aliases ] && source ~/.aliases

# Source kubectl aliases like 'kgsvcwn'
[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
