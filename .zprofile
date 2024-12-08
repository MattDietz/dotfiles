if [[ $(uname) == "Darwin" ]]; then
  source "$HOME"/.mac.zsh
else
  source "$HOME"/.linux.zsh
fi

export DISABLE_UNTRACKED_FILES_DIRTY=true

export GOPATH=~/go_path
export PATH=$PATH:$GOPATH/bin

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

export VISUAL="nvim"

# Aliases
alias ipython='ptipython'
alias ls='ls -G --color=auto'
alias dsp="docker system prune --volumes -f"

# Don't share history between terms, makes tmux less of a PITA
setopt nosharehistory

[ -f ~/.localrc ] && source ~/.localrc

# Allow for unlimited core dumps
ulimit -c unlimited
