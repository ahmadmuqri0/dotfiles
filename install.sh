#!/usr/bin/env bash
set -e

##############################################
#  PRE-CHECK: REQUIRE GUM
##############################################

if ! command -v gum &>/dev/null; then
  echo "gum is required. Exiting."
  exit 1
fi

##############################################
#  PACKAGES
##############################################
ARCH_PACKAGES=(
  sddm hyprland xorg-xwayland kitty stow zsh fzf neovim
  qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg
  ttf-jetbrains-mono-nerd lazygit eza zoxide go npm
  noctalia-shell mpv nautilus polkit-gnome xdg-desktop-portal-hyprland
  wl-clipboard tela-circle-icon-theme-all loupe cliphist
  nwg-look qt6ct gnome-software adw-gtk-theme
)

AUR_PACKAGES=(python-pywalfox)

##############################################
#  UI HELPERS (gum only)
##############################################

log() { printf "\033[1;32m[+] %s\033[0m\n" "$1"; }
warn() { printf "\033[1;33m[!] %s\033[0m\n" "$1"; }
err() { printf "\033[1;31m[!] %s\033[0m\n" "$1" >&2; }

banner() {
  gum style --foreground="#7dcfff" --border double --padding "1 2" \
    "ARTEMIS DOTFILES INSTALLER"
}

confirm() {
  gum confirm "$1"
}

##############################################
#  POPULATE USER DIRECTORY
##############################################

populate_user_dirs() {
  xdg-user-dirs-update
}

##############################################
#  PACKAGE CHECKING
##############################################

check_pacman() {
  missing_pacman_pkgs=()
  for pkg in "${ARCH_PACKAGES[@]}"; do
    if ! pacman -Qi "$pkg" &>/dev/null; then
      missing_pacman_pkgs+=("$pkg")
    fi
  done
}

check_aur() {
  missing_aur_pkgs=()
  if ! command -v paru &>/dev/null; then
    warn "paru not installed — skipping AUR."
    return
  fi

  for pkg in "${AUR_PACKAGES[@]}"; do
    paru -Qi "$pkg" &>/dev/null || missing_aur_pkgs+=("$pkg")
  done
}

##############################################
#  INSTALL STEPS
##############################################

install_pacman() {
  if [ ${#missing_pacman_pkgs[@]} -eq 0 ]; then
    log "All pacman packages installed."
    return
  fi

  log "Missing pacman packages: ${missing_pacman_pkgs[*]}"

  if confirm "Install pacman packages?"; then
    sudo pacman -S --needed --noconfirm "${missing_pacman_pkgs[@]}"
    sudo systemctl enable sddm
  fi
}

install_aur() {
  if [ ${#missing_aur_pkgs[@]} -eq 0 ]; then
    log "All AUR packages installed."
    return
  fi

  log "Missing AUR packages: ${missing_aur_pkgs[*]}"

  if confirm "Install AUR packages?"; then
    paru -S --needed --noconfirm "${missing_aur_pkgs[@]}"
  fi
}

clone_wallpapers() {
  log "Cloning wallpapers"

  if [ ! -d "$HOME/Pictures/wallpapers" ]; then
    if confirm "Clone wallpaper collection?"; then
      git clone git@github.com:ahmadmuqri0/wallpapers.git \
        $HOME/Pictures/wallpapers
    fi
  else
    log "wallpapers already exists."
  fi
}

setup_sddm_theme() {
  log "Setting up SDDM theme..."

  if [ ! -d "/usr/share/sddm/themes/sddm-artemis" ]; then
    if confirm "Clone SDDM Artemis theme?"; then
      sudo git clone --depth 1 https://github.com/ahmadmuqri0/sddm-artemis.git \
        /usr/share/sddm/themes/sddm-artemis
    fi
  else
    log "SDDM theme already exists."
  fi
}

copy_sddm_fonts() {
  THEME_FONTS="/usr/share/sddm/themes/sddm-artemis/Fonts"

  if [ ! -d "$THEME_FONTS" ]; then
    warn "Theme fonts not found — skipping."
    return
  fi

  fonts_missing=false
  for f in "$THEME_FONTS"/*; do
    name=$(basename "$f")
    if [ ! -e "/usr/share/fonts/$name" ]; then
      fonts_missing=true
    fi
  done

  if $fonts_missing; then
    if confirm "Copy theme fonts?"; then
      sudo cp -r "$THEME_FONTS"/* /usr/share/fonts/
    fi
  else
    log "Theme fonts already installed."
  fi
}

configure_sddm() {
  if grep -q "Current=sddm-artemis" /etc/sddm.conf 2>/dev/null; then
    log "SDDM theme already configured."
    return
  fi

  if confirm "Configure SDDM theme?"; then
    echo "[Theme]
Current=sddm-artemis" | sudo tee /etc/sddm.conf >/dev/null
  fi
}

configure_virtual_keyboard() {
  local target="/etc/sddm.conf.d/virtualkbd.conf"

  if grep -q "InputMethod=qtvirtualkeyboard" "$target" 2>/dev/null; then
    log "Virtual keyboard already configured."
    return
  fi

  if confirm "Enable Qt virtual keyboard?"; then
    sudo mkdir -p /etc/sddm.conf.d
    echo "[General]
InputMethod=qtvirtualkeyboard" | sudo tee "$target" >/dev/null
  fi
}

install_tpm() {
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    if confirm "Install TPM?"; then
      git clone https://github.com/tmux-plugins/tpm.git "$HOME/.tmux/plugins/tpm"
    fi
  else
    log "TPM already installed."
  fi
}

stow_dotfiles() {
  if confirm "Run 'stow .' to symlink dotfiles?"; then
    stow .
  fi
}

change_shell() {
  if [[ "$SHELL" =~ zsh$ ]]; then
    log "Shell already Zsh."
    return
  fi

  if confirm "Change default shell to Zsh?"; then
    if ! command -v zsh &>/dev/null; then
      warn "Zsh not installed."
      return
    fi
    chsh -s "$(command -v zsh)"
  fi
}

##############################################
#  MAIN
##############################################

banner

populate_user_dirs
check_pacman
check_aur

install_pacman
install_aur

clone_wallpapers

setup_sddm_theme
copy_sddm_fonts
configure_sddm
configure_virtual_keyboard

install_tpm
stow_dotfiles
change_shell

log "Installation complete! 🚀"
