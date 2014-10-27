export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=1

autoload -U colors && colors

# fpath=($ZSH/zsh/functions $fpath)

# history
setopt append_history hist_ignore_all_dups inc_append_history share_history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# cd movements
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

# don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt complete_aliases

zle -N newtab

bindkey -v # vi mode

# fix some things that vi mode breaks
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# vim mode indictator from oh-my-zsh
function zle-line-init zle-keymap-select {
  MODE_INDICATOR="%B%F{red}%b❮%F{red}❮❮%f"
  RPS1="${${KEYMAP/vicmd/$MODE_INDICATOR}/(main|viins)/}"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1 # reduce ESC delay when in vi mode
