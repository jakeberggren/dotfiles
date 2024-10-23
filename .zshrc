# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add git status functionality
function git_branch() {
    branch=$(git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/(\1)/p')
    if [[ $branch == "" ]];
    then
        echo""
    else

        echo 'on  '$branch' '
    fi
}

# Alternative git functionality with branch to the right
# autoload -Uz vcs_info
# precmd_vcs_info() { vcs_info }
# precmd_functions+=( precmd_vcs_info )
# setopt prompt_subst
# RPROMPT='${vcs_info_msg_0_}'
# PROMPT='${vcs_info_msg_0_}%# '
# zstyle ':vcs_info:git:*' formats '%b'

#Prompt indicator
#funtion prompt_indicator() {
#    if [[ "$PWD" = "$HOME" ]];then
#        echo ""
#    else
#        echo ""
#    fi
#}

# Better history
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Customize prompt
setopt PROMPT_SUBST
PROMPT='%F{magenta} %3~ %F{blue}$(git_branch)%F{green} '

# Case insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# Function to kill certain port
killport() {
  if [ -z "$1" ]; then
    echo "Please provide a port number."
  else
    kill -9 $(lsof -ti:$1)
  fi
}
# --- ALIASES BELOW ---

# PYTHON
alias py="python3"

# NAVIGATION
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# COMMON DIRECTORIES
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias home="cd ~"

# GIT
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gch="git checkout"
alias lg="lazygit"

# EZA
alias ls="eza --long --header --git --no-permissions --no-user --icons --no-time --no-filesize --tree --level=1"

#VENV
alias svenv="source venv/bin/activate"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export LANG=en_US

# PLUGINS
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jakobberggren/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jakobberggren/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/jakobberggren/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jakobberggren/miniforge3/bin:$PATH"2
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

eval "$(zoxide init --cmd cd zsh)"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
