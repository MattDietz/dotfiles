eval "$(/opt/homebrew/bin/brew shellenv)"

# PYENV
ARCH="arm64"

export PYTHONPATH=$PYENV_ROOT/shims:~/code/python:~/code/python/mailgun
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/opt/homebrew/lib"

SDK_PATH="$(xcrun --show-sdk-path)"
export CPATH="${SDK_PATH}/usr/include"
export CFLAGS="-I${SDK_PATH}/usr/include/sasl $CFLAGS"
export CFLAGS="-I/opt/homebrew/opt/openssl@1.1/include -I${SDK_PATH}/usr/include $CFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include -I/usr/local/opt/openssl/include -I/opt/homebrew/opt/openssl@3/include"
export LDFLAGS="-L/opt/homebrew/lib -L/opt/homebrew/opt/openssl@1.1/lib -L/opt/homebrew/opt/openssl@3/lib -L${SDK_PATH}/usr/lib $LDFLAGS"

if [[ "${ARCH}"  == "arm64" ]]; then
    PREFIX="/opt/homebrew/opt"
else
    PREFIX="/usr/local/opt"
fi

ZLIB="${PREFIX}/zlib"
BZIP2="${PREFIX}/bzip2"
READLINE="${PREFIX}/readline"
SQLITE="${PREFIX}/sqlite"
OPENSSL="${PREFIX}/openssl@1.1"
TCLTK="${PREFIX}/tcl-tk"
PGSQL="${PREFIX}/postgresql@10"
LIBS=('ZLIB' 'BZIP2' 'READLINE' 'SQLITE' 'OPENSSL' 'PGSQL' 'TCLTK')


export ARCHFLAGS="-arch $ARCH"
export TERM=xterm-256color

source ~/.git-completion.zsh
export DISABLE_UNTRACKED_FILES_DIRTY=true

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

PROMPT="%F{green}%1~$vcs_info_msg_0_ $PURPLE>%f "

zstyle ':vcs_info:git:*' formats '%F{magenta}(%b)%f'
# zstyle ':vcs_info:*' enable git


export GOPATH=~/go_path
export PATH=$PATH:$GOPATH/bin

export VISUAL="vim"

# Don't share history between terms, makes tmux less of a PITA
setopt nosharehistory

# Allow for unlimited core dumps
ulimit -c unlimited
