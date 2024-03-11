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

# Alternative git functionality
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

# Customize prompt
setopt PROMPT_SUBST
PROMPT='%F{magenta} %3~ %F{blue}$(git_branch)%F{green} '

# Activate colors for command ls
export CLICOLOR=1 #Turn colors on
# export LSCOLORS=ExFxBxDxCxegedabagacad #Customize colors for command ls
# export LSCOLORS=gafacadabaegedabagacad #Customize colors for commands ls
# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Case insensitive tab completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

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
alias dgit="cd ~/Desktop/Git" 

# GIT
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gch="git checkout"
alias lg="lazygit"

#VENV
alias svenv="source venv/bin/activate"
alias kill5000='kill -9 $(lsof -ti:5000)'
alias kill8000='kill -9 $(lsof -ti:8000)'

#SMS
alias mess="osascript ~/Desktop/SendMessage.scpt"
alias akke.nr="0739156399"
alias hugge.nr="0707232389"

#SSH
alias liussh="ssh -Y jakbe841@ssh.edu.liu.se"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
        export PATH="/Users/jakobberggren/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

