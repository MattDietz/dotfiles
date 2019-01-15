export ARCHFLAGS="-arch x86_64"
export TERM=screen-256color

source ~/.git-completion.bash

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function dirty_branch {
  local DIFF_YELLOW='\033[1;34m'
  local DIFF_RED='\033[0;31m'
  git diff --exit-code &> /dev/null
  DIFF=$?
  if [ $DIFF -ne 0 ] && [ $DIFF -ne 129 ]; then
    echo -e ${DIFF_RED}
  else
    echo -e ${DIFF_YELLOW}
  fi
}

function git_prompt {
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local  PURPLE="\[\033[1;34m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
PS1="$PURPLE\h$GREEN ${TITLEBAR}\
$GREEN\
\w\$(dirty_branch)\$(parse_git_branch)$GREEN\
$PURPLE >$GREEN "
PS2='> '
PS4='+ '
}
git_prompt

alias ack='ack --color --group --column'
alias ls='ls -G'

[[ -z `which kubectl` ]] || source <(kubectl completion bash)

export GOPATH=~/go_path
export PATH=$PATH:$GOPATH/bin:~/.devgun/bin:$GOPATH/bin

alias ipython='ptipython'

function vim() {
  if test $# -gt 0; then
    env nvim "$@"
  elif test -f Session.vim; then
    env nvim -S
  else
    env nvim -c Obsession
  fi
}

function goplay() {
  cat > ./play.go <<- EOM
package main

import "fmt"

func main() {
  fmt.Println("hello!")
}
EOM
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper

[ -f ~/.localrc ] && source ~/.localrc
