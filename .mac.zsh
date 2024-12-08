eval "$(/opt/homebrew/bin/brew shellenv)"

# PYENV
ARCH="arm64"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="/opt/homebrew/lib:$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper
PYENV_BIN="$PYENV_ROOT/bin"
export PYENV_SHELL=zsh
export PYTHONPATH=$PYENV_ROOT/shims
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:/opt/homebrew/lib"

SDK_PATH="$(xcrun --show-sdk-path)"
export CPATH="${SDK_PATH}/usr/include"
export CFLAGS="-I${SDK_PATH}/usr/include/sasl $CFLAGS"
export CFLAGS="-I/opt/homebrew/opt/openssl@1.1/include -I${SDK_PATH}/usr/include $CFLAGS"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include -I/usr/local/opt/openssl/include"
export LDFLAGS="-L/opt/homebrew/lib -L/opt/homebrew/opt/openssl@1.1/lib -L${SDK_PATH}/usr/lib $LDFLAGS"

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
export TERM=screen-256color

source ~/.git-completion.zsh

zstyle ':vcs_info:git:*' formats '%F{magenta}(%b)%f'

[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
