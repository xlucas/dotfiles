#=======================
# Base configuration
#=======================

# Custom theme
ZSH_THEME="robbyrussell"

# History time format
HIST_STAMPS="dd.mm.yyyy"

# Completion processing is signaled by red dots
COMPLETION_WAITING_DOTS="true"

# Updates
export DISABLE_AUTO_UPDATE="true"

# Path to oh-my-zsh installation
export ZSH=$HOME/.oh-my-zsh

# Plugin pipeline
plugins=(git history history-substring-search zsh-syntax-highlighting)


#=======================
# Additional confs
#=======================

# oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Golang version manager
source $HOME/.gvm/scripts/gvm

# Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Solarized directory colors
eval `dircolors $HOME/.dir_colors/dircolors.256dark`


#=======================
# Environment variables
#=======================
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/usr/sbin"
PATH="$PATH:/usr/bin"
PATH="$PATH:/sbin"
PATH="$PATH:/bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.rvm/bin"
MANPATH="$MANPATH:/usr/local/man"

export EDITOR=vim
export MANPATH
export PATH
export TERM=xterm-256color


#=======================
# Aliases
#=======================
alias browser='nautilus --no-desktop'
alias egrep='egrep --color'
alias fgrep='fgrep --color'
alias git='hub'
alias grep='grep --color'
alias l='ls -lh --color --group-directories-first'
alias less='less -R'
alias ll='ls -alh --color --group-directories-first'
alias vi='vim'
alias zgrep='zgrep --color'


#=======================
# Shell options
#=======================
setopt inc_append_history
setopt histappend
setopt share_history


#=======================
# Completion
#=======================
fpath=($HOME/.zsh/completion $fpath)
autoload -U compinit
compinit

if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && exec tmux
fi
