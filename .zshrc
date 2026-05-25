# ---------- HISTORY ----------
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

# ---------- SHELL BEHAVIOR ----------
setopt AUTOCD
setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# ---------- ZOXIDE ----------
eval "$(zoxide init zsh)"

# ---------- COMPLETION ----------
fpath=($XDG_DATA_HOME/zsh/site-functions $fpath)
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ---------- FUZZY FINDER ----------
if [[ -f /usr/share/fzf/shell/key-bindings.zsh ]]; then
  source /usr/share/fzf/shell/key-bindings.zsh
fi

# ---------- CONFIG FILES ----------
CONFIGDIR="$XDG_CONFIG_HOME/zsh"
source "$CONFIGDIR/fzf.zsh"
source "$CONFIGDIR/aliases.zsh"
source "$CONFIGDIR/git.zsh"
source "$CONFIGDIR/bindings.zsh"
source "$CONFIGDIR/plugins.zsh"
source "$CONFIGDIR/prompt.zsh"
