# ---------- XDG BASE DIRECTORIES ----------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# ---------- EDITOR ----------
export EDITOR="zed"
export VISUAL="zed"

# ---------- GPG ----------
export GPG_TTY=$(tty)

if grep -qi microsoft /proc/version 2>/dev/null; then
  stty icrnl
fi

# ---------- CARGO ----------
. "$HOME/.cargo/env"

# ---------- PATH ----------
export PATH="$PATH:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$HOME/.bun/bin:$HOME/go/bin"

# ---------- PAGER ----------
export MANPAGER="bat -l man -p"
