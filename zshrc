# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/dotfiles
export VAULT_PATH=/Volumes/shadowfax/Dropbox/.vault

# aliases
alias reload!='. ~/.zshrc'

# completion
autoload -U compinit
compinit

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load zsh files
for file in ${config_files}; do
  source $file
done

# antigen
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle sindresorhus/pure
antigen bundle sharat87/autoenv

antigen apply

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

unset config_files

# SUPER SECRET CRAP
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
