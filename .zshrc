#=======================
# Base configuration
#=======================

# Custom theme
ZSH_THEME="robbyrussell"

# History time format
HIST_STAMPS="dd.mm.yyyy"

# Completion processing is signaled by red dots
COMPLETION_WAITING_DOTS="true"

# Update check frequency
export UPDATE_ZSH_DAYS=15

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

# Shell colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1"  ] && [ -s $BASE16_SHELL/profile_helper.sh  ] && eval "$($BASE16_SHELL/profile_helper.sh)"

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
alias l='ls -lh --color --group-directories-first'
alias ll='ls -alh --color --group-directories-first'
alias grep='grep --color'
alias fgrep='fgrep --color'
alias egrep='egrep --color'
alias zgrep='zgrep --color'
alias less='less -R'
alias browser='nautilus --no-desktop'


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
