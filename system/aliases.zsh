# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la="gls -A --color"
fi

# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# Quick look stuff
alias ql="qlmanage -p &>/dev/null"

# Unix
alias mkdir='mkdir -p'
alias ...='../..'
alias e="$EDITOR"
alias v="$VISUAL"
alias search='ag'

# Git
alias gst='git status -sb'
alias gl='git log --graph --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%cD%C(reset) %C(bold green)(%cr)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)" --abbrev-commit'
alias gd='git diff'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'

# Ruby
alias be='bundle exec'
alias bi='bundle install --path vendor'
