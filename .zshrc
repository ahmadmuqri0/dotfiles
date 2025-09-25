# env
source $HOME/.zshenv

# aliases
source $HOME/.zsh_aliases

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not already done
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add starship
zinit ice from"gh-r" as"program" bpick"*starship*"; zinit light starship/starship
eval "$(starship init zsh)"

# Add zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q


# Keybindings
bindkey -v
bindkey "^p" history-search-backward
bindkey "^n" history-search-forward
bindkey '^f' forward-char

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completions styling
zstyle ":completions:*" matcher-list "m:{a-z}={A-Za-z}"
zstyle ":completions:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ":completions:*" menu no
zstyle ":fzf-tab:complete:cd:*" fzf-preview "ls --color $realpath"
zstyle ":fzf-tab:complete:__zoxide-z:*" fzf-preview "ls --color $realpath"

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# bun completions
[ -s "/home/muqri/.bun/_bun" ] && source "/home/muqri/.bun/_bun"
