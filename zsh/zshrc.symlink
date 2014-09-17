# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/dotfiles
export VAULT_PATH=/Volumes/shadowfax/Dropbox/.vault

# aliases
alias reload!='. ~/.zshrc'

# all of our zsh files
typeset -U config_files
config_files=($ZSH/**/*.zsh)

# load the path files
for file in ${(M)config_files:#*/path.zsh}
do
	source $file
done

# load everything but the path and completion files
for file in ${${config_files:#*/path.zsh}:#*/completion.zsh}
do
	source $file
done

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle sindresorhus/pure
antigen bundle sharat87/autoenv

antigen apply

# use .localrc for SUPER SECRET CRAP that you don't
# want in your public, versioned repo.
if [[ -a ~/.localrc ]]
then
	source ~/.localrc
fi

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

# load every completion after autocomplete loads
for file in ${(M)config_files:#*/completion.zsh}
do
	source $file
done

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

unset config_files
