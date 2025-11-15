#!/usr/bin/env bash

set -e

### ----------------------------------
###  ASCII ART BANNER
### ----------------------------------
show_banner() {
  cat <<'EOF'

    █████╗ ██████╗ ████████╗███████╗███╗   ███╗██╗███████╗
   ██╔══██╗██╔══██╗╚══██╔══╝██╔════╝████╗ ████║██║██╔════╝
   ███████║██████╔╝   ██║   █████╗  ██╔████╔██║██║███████╗
   ██╔══██║██╔══██╗   ██║   ██╔══╝  ██║╚██╔╝██║██║╚════██║
   ██║  ██║██║  ██║   ██║   ███████╗██║ ╚═╝ ██║██║███████║
   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚═╝╚══════╝

                    A R T E M I S   D O T S
------------------------------------------------------------
EOF
}

### ----------------------------------
###  Config
### ----------------------------------

ARCH_PACKAGES=(
  sddm hyprland xorg-xwayland stow zsh fzf neovim
  qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
  ttf-jetbrains-mono-nerd lazygit eza zoxide go npm
  noctalia-shell mpv nautilus xdg-desktop-portal-hyprland
  wl-clipboard tela-circle-icon-theme-all loupe cliphist
  nwg-look qt6ct gnome-software
)

AUR_PACKAGES=(python-pywalfox)

### ----------------------------------
###  Helpers
### ----------------------------------

log() { printf "\033[1;32m[+] %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m[!] %s\033[0m\n" "$1"; }
err() { printf "\033[1;31m[!] %s\033[0m\n" "$1" >&2; }

### ----------------------------------
###  Flags
### ----------------------------------

DRY_RUN=false
INTERACTIVE=false

for arg in "$@"; do
  case "$arg" in
  --dry-run | -n) DRY_RUN=true ;;
  --interactive | -i) INTERACTIVE=true ;;
  *)
    err "Unknown option: $arg"
    exit 1
    ;;
  esac
done

### ----------------------------------
###  Interactive Prompts
### ----------------------------------

confirm() {
  local prompt="$1"
  local response

  if [ "$INTERACTIVE" = false ]; then
    return 0
  fi

  while true; do
    read -rp "$prompt [y/n]: " response
    case "$response" in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}

### ----------------------------------
###  Main
### ----------------------------------

show_banner

if [ "$DRY_RUN" = true ]; then
  warn "Dry-run enabled — no changes will be made."
fi
if [ "$INTERACTIVE" = true ]; then
  log "Interactive mode enabled."
fi

### OS CHECK
if ! command -v pacman &>/dev/null; then
  err "This installer is for Arch Linux (pacman). Exiting."
  exit 1
fi

### DETECT MISSING PACMAN PKGS
missing_pacman_pkgs=()
for pkg in "${ARCH_PACKAGES[@]}"; do
  if ! pacman -Qi "$pkg" &>/dev/null; then
    missing_pacman_pkgs+=("$pkg")
  fi
done

### DETECT MISSING AUR PKGS
missing_aur_pkgs=()

if command -v paru &>/dev/null; then
  for pkg in "${AUR_PACKAGES[@]}"; do
    if ! paru -Qi "$pkg" &>/dev/null; then
      missing_aur_pkgs+=("$pkg")
    fi
  done
else
  warn "paru not installed — skipping AUR checks."
fi

### PACKMAN INSTALL
if [ ${#missing_pacman_pkgs[@]} -gt 0 ]; then
  log "Missing pacman packages detected: ${missing_pacman_pkgs[*]}"

  if confirm "Install these pacman packages?"; then
    if [ "$DRY_RUN" = false ]; then
      sudo pacman -S --needed --noconfirm "${missing_pacman_pkgs[@]}"
      sudo systemctl enable sddm
    else
      warn "(dry-run) Would install pacman packages."
    fi
  else
    warn "Skipping pacman installs."
  fi
else
  log "All pacman packages already installed."
fi

### AUR INSTALL
if [ ${#missing_aur_pkgs[@]} -gt 0 ] && command -v paru &>/dev/null; then
  log "Missing AUR packages detected: ${missing_aur_pkgs[*]}"

  if confirm "Install these AUR packages?"; then
    if [ "$DRY_RUN" = false ]; then
      paru -S --needed --noconfirm "${missing_aur_pkgs[@]}"
    else
      warn "(dry-run) Would install AUR packages."
    fi
  else
    warn "Skipping AUR installs."
  fi
fi

### ----------------------------------
###  SDDM THEME SETUP
### ----------------------------------

log "Setting up SDDM theme..."

### Clone SDDM Artemis theme
if [ ! -d "/usr/share/sddm/themes/sddm-artemis" ]; then
  if confirm "Clone SDDM Artemis theme?"; then
    if [ "$DRY_RUN" = false ]; then
      log "Cloning SDDM Artemis theme..."
      sudo git clone --depth 1 https://github.com/ahmadmuqri0/sddm-artemis.git /usr/share/sddm/themes/sddm-artemis
    else
      warn "(dry-run) Would clone SDDM Artemis theme."
    fi
  else
    warn "Skipping SDDM theme clone."
  fi
else
  log "SDDM Artemis theme already exists."
fi

### Copy fonts if needed
THEME_FONTS_DIR="/usr/share/sddm/themes/sddm-artemis/Fonts"
if [ -d "$THEME_FONTS_DIR" ]; then
  # Check if fonts are already copied
  fonts_exist=true
  for font in "$THEME_FONTS_DIR"/*; do
    font_name=$(basename "$font")
    if [ ! -f "/usr/share/fonts/$font_name" ]; then
      fonts_exist=false
      break
    fi
  done

  if [ "$fonts_exist" = false ]; then
    if confirm "Copy SDDM theme fonts to system fonts?"; then
      if [ "$DRY_RUN" = false ]; then
        log "Copying fonts..."
        sudo cp -r "$THEME_FONTS_DIR"/* /usr/share/fonts/
      else
        warn "(dry-run) Would copy fonts to /usr/share/fonts/"
      fi
    else
      warn "Skipping font installation."
    fi
  else
    log "Theme fonts already installed."
  fi
else
  warn "Font directory $THEME_FONTS_DIR not found — skipping font copy."
fi

### Configure SDDM theme
if confirm "Configure SDDM to use Artemis theme?"; then
  if [ "$DRY_RUN" = false ]; then
    log "Setting SDDM theme configuration..."
    echo "[Theme]
Current=sddm-artemis" | sudo tee /etc/sddm.conf >/dev/null
  else
    warn "(dry-run) Would write to /etc/sddm.conf"
  fi
else
  warn "Skipping SDDM theme configuration."
fi

### Configure virtual keyboard
if confirm "Enable Qt virtual keyboard for SDDM?"; then
  if [ "$DRY_RUN" = false ]; then
    log "Configuring virtual keyboard..."
    sudo mkdir -p /etc/sddm.conf.d
    echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee /etc/sddm.conf.d/virtualkbd.conf >/dev/null
  else
    warn "(dry-run) Would write to /etc/sddm.conf.d/virtualkbd.conf"
  fi
else
  warn "Skipping virtual keyboard configuration."
fi

### ----------------------------------
###  TPM & DOTFILES
### ----------------------------------

### TPM INSTALL
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  if confirm "Install Tmux Plugin Manager (TPM)?"; then
    if [ "$DRY_RUN" = false ]; then
      log "Installing TPM..."
      git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
    else
      warn "(dry-run) Would clone TPM."
    fi
  else
    warn "Skipping TPM install."
  fi
else
  log "TPM already installed."
fi

### STOW DOTFILES
log "Preparing to stow dotfiles…"

if confirm "Run 'stow .' for all packages?"; then
  if [ "$DRY_RUN" = false ]; then
    stow .
    log "Symlinked all dotfiles."
  else
    warn "(dry-run) Would run: stow ."
  fi
else
  warn "Skipping stow operation."
fi

### ----------------------------------
###  Change default shell to Zsh
### ----------------------------------

if [ "$SHELL" = "/usr/bin/zsh" ] || [ "$SHELL" = "/bin/zsh" ]; then
  log "Your shell is already Zsh."
else
  if confirm "Change your default shell to Zsh?"; then
    if ! command -v zsh &>/dev/null; then
      warn "Zsh is not installed — skipping shell change."
    else
      if [ "$DRY_RUN" = false ]; then
        log "Changing default shell to Zsh..."
        chsh -s "$(command -v zsh)"
      else
        warn "(dry-run) Would run: chsh -s $(command -v zsh)"
      fi
    fi
  else
    warn "Skipping shell change."
  fi
fi

log "Installation complete! 🚀"
[ "$DRY_RUN" = true ] && warn "Dry-run complete — no changes were made."
