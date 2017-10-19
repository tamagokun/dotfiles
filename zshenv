export VISUAL='nvim'
export EDITOR=$VISUAL

export PATH="./bin:$HOME/.bin:/usr/local/bin:/usr/local/sbin:$ZSH/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/git/man:$MANPATH"

# Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# PHP
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Go
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

# Node
export NODE_PATH="/usr/local/lib/node_modules:$NODE_PATH"
export PATH="$(yarn global bin):/usr/local/share/npm/bin:$PATH"

# Android
export ANDROID_HOME=~/Library/Android/sdk
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

# Flash/Flex
export PATH="/usr/local/Cellar/flex_sdk/4.6/bin":$PATH
# export FLEX_HOME="/usr/local/Cellar/flex_sdk/4.6.0.23201/libexec"
# export PATH="$HOME/Sites/flash/AdobeAIRSDK/bin:$PATH"

# load fzf
export FZF_DEFAULT_COMMAND='ag -l -g ""'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
