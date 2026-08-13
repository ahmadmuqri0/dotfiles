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

if grep microsoft /proc/version 2>/dev/null; then
  stty icrnl
fi

# ---------- CARGO ----------
if ! grep microsoft /proc/version 2>/dev/null; then
  . "$HOME/.cargo/env"
fi

# ---------- PATH ----------
export PATH="$PATH:$HOME/.local/bin:$HOME/.config/composer/vendor/bin:$HOME/.bun/bin:$HOME/go/bin:$HOME/.opencode/bin:$HOME/.local/share/fnm:$HOME/.local/share/pnpm"

# ---------- PAGER ----------
export MANPAGER="bat -l man -p"
