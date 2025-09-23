# Dotfiles Setup

A collection of configuration files for a modern development environment featuring Neovim, Alacritty, Zsh, and more.

## Quick Setup

1. **Clone the repository**

   ```bash
   git clone git@github.com:ahmadmuqri0/dotfiles.git $HOME/.local/share/dotfiles
   cd $HOME/.local/share/dotfiles
   ```

2. **Install GNU Stow** (if not already installed)

   ```bash
   # On Arch Linux
   sudo pacman -S stow
   ```

3. **Symlink configurations**

   ```bash
   stow .
   ```

4. **Install dependencies**
   - **Font**: JetBrains Mono Nerd Font
   - **Terminal**: Alacritty
   - **Shell**: Zsh
   - **Tools**: git, neovim, lazygit, eza, bat, fzf, zoxide, starship

That's it! Your dotfiles are now active. Restart your terminal or source your shell configuration to see the changes.

## What's Included

- **Neovim**: LazyVim configuration with language support for Go, TypeScript, PHP, and more
- **Alacritty**: Terminal emulator with Nord theme
- **Zsh**: Enhanced shell with zinit plugin manager and useful aliases
- **Starship**: Modern shell prompt with git integration
- **Lazygit**: Git TUI with custom Nord theme

## Notes

- The configuration uses the Nord color scheme throughout
- Neovim is set up with LazyVim and includes LSP support for multiple languages
- Zsh includes syntax highlighting, autosuggestions, and fuzzy finding capabilities
