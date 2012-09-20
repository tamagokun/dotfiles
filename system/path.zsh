export PATH="./bin:$ZSH/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/X11/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/git/man:$MANPATH"

#rbenv needs to be first
export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.phpenv/bin:$PATH"

#phpenv
eval "$(phpenv init -)"
