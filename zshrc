# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/dotfiles

# aliases
alias reload!='. ~/.zshrc'
alias npmsucks='rm -rf ./node_modules && npm install'

# completion
autoload -U compinit
compinit

# load zsh config files
for file in $ZSH/**/*.zsh; do
  source $file
done

# load zsh env
source $ZSH/zshenv

# antibody
antibody bundle < $ZSH/zsh/plugins.bundle > ~/.bundles.txt
source ~/.bundles.txt

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# fzf helpers
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# SUPER SECRET CRAP
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
