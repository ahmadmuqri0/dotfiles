export EDITOR=vim
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$HOME/.gem"
. "$HOME/.cargo/env"
export GPG_TTY=$(tty)
export PATH="$PATH:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$HOME/.bun/bin:$HOME/go/bin:$GEM_PATH/bin"
stty icrnl
