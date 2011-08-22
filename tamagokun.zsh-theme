local user='%{$fg[cyan]%}%n%{$reset_color%}'
local pwd='%{$fg_bold[yellow]%}${PWD/#$HOME/~}%{$reset_color%}'
local rvm='%{$fg[magenta]%}$(rvm-prompt s g)%{$reset_color%}'
local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
local git_branch='$(prompt_git_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}!"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}⚡"
ZSH_THEME_GIT_PROMPT_DELETED=""
ZSH_THEME_GIT_PROMPT_RENAMED=""
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}?"

PROMPT="${user} ${pwd} %"
RPROMPT="${return_code} ${git_branch}${rvm}"

function update_current_git_vars() {
	unset __CURRENT_GIT_BRANCH
	unset __CURRENT_GIT_BRANCH_STATUS
	unset __CURRENT_GIT_BRANCH_IS_DIRTY

	local st="$(git status 2>/dev/null)"
	if [[ -n "$st" ]]; then
	    local -a arr
	    arr=(${(f)st})

	    if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
	        __CURRENT_GIT_BRANCH='no-branch'
	    else
	        __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
	    fi

	    if [[ $arr[2] =~ 'Your branch is' ]]; then
	        if [[ $arr[2] =~ 'ahead' ]]; then
	            __CURRENT_GIT_BRANCH_STATUS='ahead'
	        elif [[ $arr[2] =~ 'diverged' ]]; then
	            __CURRENT_GIT_BRANCH_STATUS='diverged'
	        else
	            __CURRENT_GIT_BRANCH_STATUS='behind'
	        fi
	    fi

	    if [[ ! $st =~ 'nothing to commit' ]]; then
	        __CURRENT_GIT_BRANCH_IS_DIRTY='1'
	    fi
	fi
}

function prompt_git_info() {
	update_current_git_vars
	if [ -n "$__CURRENT_GIT_BRANCH" ]; then
	    local s="("
	    s+="$__CURRENT_GIT_BRANCH"
		local t=""
	    case "$__CURRENT_GIT_BRANCH_STATUS" in
	        ahead)
	        t+="↑"
	        ;;
	        diverged)
	        t+="↕"
	        ;;
	        behind)
	        t+="↓"
	        ;;
	    esac
	    if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
	        t+="⚡"
	    fi

	    printf " %s%s" "%{$fg_bold[blue]%}" $s"%{$fg_bold[yellow]%}"$t"%{$fg_bold[blue]%})%{$reset_color%}"
	fi
}
