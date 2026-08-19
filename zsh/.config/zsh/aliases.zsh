alias c='clear'
alias e='exit'

alias mkdir='mkdir -pv'

alias ls='eza -la --icons --git --color=always --group-directories-first'
alias ll='eza -alF --icons --git --color=always --group-directories-first'

alias tree='eza --tree --icons --color=always --group-directories-first'

compdef eza=ls

alias cat='bat'

alias grep='rg --color=auto'

alias artisan='php artisan'

alias fetch='fastfetch --config examples/13'

alias task='go-task'

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

alias ns="nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history"

# wsl
alias clip='clip.exe'
