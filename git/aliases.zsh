# Use `hub` as our git wrapper:
#   http://defunkt.github.com/hub/
hub_path=$(which hub &>/dev/null)
if (( $+commands[hub] ))
then
  alias git=$hub_path
fi

alias gst='git status -sb'
alias gl='git log --graph --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%cD%C(reset) %C(bold green)(%cr)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(bold white)— %cn%C(reset)" --abbrev-commit'
alias gd='git diff'
alias gc='git commit'
alias gco='git checkout'
alias gb='git branch'
