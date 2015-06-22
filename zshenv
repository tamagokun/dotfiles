export VISUAL='nvim'
export EDITOR=$VISUAL

export PATH="./bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/git/man:$MANPATH"

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# PHP
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Go
export GOPATH="$HOME/.go"

# Node
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
export PATH="/usr/local/share/npm/bin:$PATH"

# Flash/Flex
# export PATH="/usr/local/Cellar/flex_sdk/4.6.0.23201/libexec/bin:$PATH"
# export FLEX_HOME="/usr/local/Cellar/flex_sdk/4.6.0.23201/libexec"
# export PATH="$HOME/Sites/flash/AdobeAIRSDK/bin:$PATH"

# load fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
