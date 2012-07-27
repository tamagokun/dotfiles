autoload colors && colors

git_branch() {
  echo $(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(/usr/local/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
	echo ""
  else
	if [[ $st == "nothing to commit (working directory clean)" ]]
	then
	  echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
	else
	  echo "on %{$fg_bold[red]%}$(git_prompt_info)%{$reset_color%}"
	fi
  fi
}

git_prompt_info() {
 ref=$(/usr/local/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed() {
  /usr/local/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push() {
  if [[ $(unpushed) == "" ]]
  then
	echo " "
  else
	echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

rb_prompt(){
  if $(which rbenv &> /dev/null)
  then
	  echo "%{$fg_bold[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
	else
	  echo ""
  fi
}

remote_host(){
  if [[ -n $SSH_CONNECTION ]]
  then
	echo " at %{$fg_bold[magenta]%}%m%{$reset_color%}"
  else
	echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

export PROMPT=$'\n$(rb_prompt)$(remote_host) in $(directory_name) $(git_dirty)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$fg_bold[cyan]%}%{$reset_color%}"
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
