alias ga='git add'
alias gwip='git add -A; git ls-files --deleted -z | xargs -0 git rm; git commit -m "--wip--"'

alias gb='git branch'
alias gba='git branch -a'

alias gco='git checkout'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcmsg='git commit -m'

alias gd='git diff'
alias gdc='git diff --cached'

alias glg='git log --stat --max-count=10'
alias glgg='git log --graph --max-count=10'
alias glgga='git log --graph --decorate --all'
alias glo='git log --oneline'

alias gm='git merge'
alias gmt='git mergetool --no-prompt'

alias gp='git push'

alias gl='git pull'
alias gup='git pull --rebase'
alias ggpur='git pull --rebase origin $(current_branch)'

alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'

alias gr='git remote'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias grv='git remote -v'

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

alias gclean='git reset --hard && git clean -dfx'

alias gss='git status -s'
alias gst='git status'

alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
