#
# ~/.bashrc
#

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) exit;;
esac

PROMPT_COMMAND='history -a;history -n'
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

export EDITOR='vim'

export PS1="\W "

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
PATH=$PATH:/home/francis/bin:/home/francis/.local/bin
export GOPATH=$HOME/src/go

source /etc/profile.d/autojump.bash
source /usr/share/fzf/key-bindings.bash
#source /usr/share/fzf/completion.bash

alarm(){
	at -f <(echo alert "${@:2}") $1
}

alias note="vim /home/francis/Documents/miscnotes.txt"
alias nvim="TERM=tmux-256color nvim"
#fun FZF stuff
tb() {
	trans -b $@ | xclip -f -selection "clipboard"
}

ffg() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
 sudo reptyr -s $pid
  #doesn't work
}
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

cf() {
  local file

  file="$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1)"

  if [[ -n $file ]]
  then
     if [[ -d $file ]]
     then
        cd -- $file
     else
        cd -- ${file:h}
     fi
  fi
}
sf() {
  if [ "$#" -lt 1 ]; then echo "Supply string to search for!"; return 1; fi
  printf -v search "%q" "$*"
  include="txt,yml,js,json,php,md,styl,pug,jade,html,config,py,cpp,c,go,hs,rb,conf,fa,lst"
  exclude=".config,.git,node_modules,vendor,build,yarn.lock,*.sty,*.bst,*.coffee,dist"
  rg_command='rg --no-messages --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --color "always" -g "*.{'$include'}" -g "!{'$exclude'}/*"'
  files=`eval $rg_command $search | fzf --ansi --multi --reverse | awk -F ':' '{print $1":"$2":"$3}'`
  [[ -n "$files" ]] && ${EDITOR:-vim} $files
}
# If not running interactively, don't do anything
alias ls='ls --color=auto'
# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/firefox
EDITOR=/usr/bin/vim
# <<< END ADDED BY CNCHI INSTALLER

stty -ixon


# HSTR configuration - add this to ~/.bashrc
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between Bash memory and history file
bind '"\C-r": "\e0ihstr -- \C-j"'
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\e0ihstr -k \C-j"'; fi

