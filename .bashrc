export ARCHFLAGS="-arch x86_64"
export TERM=xterm-256color

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

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

alias ack='ack --color --group --column'
alias ls='ls -G'
# alias vim="/usr/local/bin/nvim"
alias gomailgun="cd ~/go_path/src/github.com/mailgun"
alias pymailgun="cd ~/code/python/mailgun"

#source /usr/local/bin/virtualenvwrapper.sh
#source /Users/cerberus/.pyenv/shims/virtualenvwrapper.sh
[[ -z `which kubectl` ]] || source <(kubectl completion bash)

export GOPATH=~/go_path
export PATH=$PATH:$GOPATH/bin:~/.devgun/bin:$GOPATH/bin

# Devgun
export PATH=/Users/cerberus/.devgun/bin:$PATH
export ETCD_ENDPOINT=http://etcd:2379
alias cqlsh='/Users/cerberus/.devgun/bin/kubectl exec cassandra-0 --stdin --tty -c cassandra -- bash -xc cqlsh.sh'
alias kc='kubectl'
alias etcdctl='kc exec etcd-0 -- /etcdctl'
alias mongo='kc exec -it $(kubectl get po -l app=mongodb -o jsonpath={.items[].metadata.name}) -- mongo'
alias redis='kc exec -it $(kubectl get po -l app=redis -o jsonpath={.items[].metadata.name}) -- redis-cli'
alias zkCli='kc exec zookeeper-0 --stdin --tty -c zookeeper -- /opt/zookeeper/bin/zkCli.sh'

alias ipython='ptipython'

# Eventbus stuff
export EVENTBUS_ENDPOINT=kafka-pixy:19091
export KAFKA_PIXY_ENDPOINT=kafka-pixy:19091

function vim() {
  if test $# -gt 0; then
    env nvim "$@"
  elif test -f Session.vim; then
    env nvim -S
  else
    env nvim -c Obsession
  fi
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# . ~/.pyenv/versions/3.6.4/bin/virtualenvwrapper.sh
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
