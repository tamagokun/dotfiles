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

# antigen
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure
antigen bundle horosgrisa/autoenv
antigen bundle theunraveler/zsh-fancy_ctrl_z

antigen apply

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# fzf helpers
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# SUPER SECRET CRAP
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
