Don't forget to install exuberant-ctags. You should totally give yourself an install script later to set everything up ;-)

# Neovim

Requires .config/nvim and .config/nvim/init.vim. Easiest solution is symlinking ~/.vim -> .config/nvim and ~/.vimrc -> .config/nvim/init.vim

I'm sure the locations will change again tomorrow.

# ZSH

Uses oh-my-zsh, so make sure to install that

Also plugins:
* git - nothing to do, built in
* fzf - requires install
  * OSX: `brew install fzf && $(brew --prefix)/opt/fzf/install`
* zsh-syntax-highlighting - requires install
  * OSX: `brew install zsh-syntax-highlighting`

# Alacritty

Create ~/.config/alacritty. Clone https://github.com/alacritty/alacritty-theme as alacritty
