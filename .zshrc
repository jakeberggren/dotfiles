# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LANG=en_US

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

# ---- PLUGINS ----
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# ---- ALIASES ----

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

#VENV
alias svenv="source venv/bin/activate"

# ---- eza (instead of cd) ----
alias ls="eza --long --header --git --git-repos-no-status --no-permissions --no-user --icons --no-time --no-filesize --tree --level=1"

# ---- zoxide (instead of ls) ----
eval "$(zoxide init --cmd cd zsh)"

# ---- bat (instead of cat) ----
export BAT_THEME="Dracula"
alias cat="bat"

# ---- FZF -----
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Dracula theme for fzf
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command="$1"
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

alias sd="cd ~ && cd \$(find * -type d | fzf --preview 'eza --tree --color=always {}')"

# ---- Node verison Manager ----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---- Conda ----
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

### No longer in use ###

# Add git status functionality
# function git_branch() {
#    branch=$(git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/(\1)/p')
#    if [[ $branch == "" ]];
#    then
#        echo""
#    else
#
#        echo 'on  '$branch' '
#    fi
#}