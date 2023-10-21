# # custom_theme.zsh-theme

# # Styling git repos

# # ⎇ means dir is git
# # main = red flashing
# # dev = purple
# # feature/ = yellow
# # other = white

# # 🖥️ = local repo only, 😺 = Github remote, 🔗 = other git remote

# # ⎿ = local: green = latest, red = outdated (remote is latest), white = no commits
# # ⏋ = remote: green = latest, red = outdated (local is latest), white = remote branch doesn't exist
# #  E = error with local/remote check.
# # run 'gitcompare' to run compare script with print out

# git_prompt_info() {
#   local ref
#   ref=$(git symbolic-ref HEAD 2>/dev/null) || return 0
#   local branch_name="${ref#refs/heads/}"

#   # branch styles
#   if [ -n "$branch_name" ]; then
#     # default = white
#     local branch_color="%{$fg[white]%}"
#     # main = blinking red
#     if [[ "$branch_name" == "main" || "$branch_name" == "master" ]]; then
#     local branch_color="\033[37;41;5m"
#     # dev, develop, development = purple
#     elif [[ "$branch_name" == "dev" || "$branch_name" == "develop" || "$branch_name" == "development" ]]; then
#     local branch_color="%{$fg[magenta]%}"
#     # feature/ = yellow
#     elif [[ "$branch_name" == feature/* ]]; then
#       branch_color="%{$fg[yellow]%}"
#     fi

#     # if dirty tree; contains changes
#     local dirty_color="%{$fg[yellow]%}"
#     local state=" "
#     if [[ -n $(git status -s 2> /dev/null) ]]; then
#       state="${dirty_color} ✧%f "
#     fi

#     local git_symbol=""
#     local git_status=""
#     if [[ $(git remote | grep -c 'origin') -gt 0 ]]; then
#       local origin_url=$(git remote get-url origin)
#       if [[ $origin_url == *"github.com"* ]]; then
#         # GitHub-connected repository with GitHub logo
#         # git_symbol="☁️ "
#         git_symbol="😺" # or if you want Github to be a cat
#       else
#         # Local repository with an 'origin' remote, but not GitHub
#         git_symbol="🔗"
#       fi

#       if [[ -f "/tmp/git_status.tmp" ]]; then
#         GIT_STATUS=$(cat /tmp/git_status.tmp)
#       else
#         GIT_STATUS=""
#       fi

#       case $GIT_STATUS in
#         "local")
#           # git_status_r="%{$fg[red]%}⎾%f "
#           # git_status_l="%{$fg[green]%}⏌%f "
#           # git_status = git_status_r + git_status_l
#           git_status="%{$fg[green]%}⎿%f%{$fg[red]%}⏋%f "
#           ;;
#           # ⏋⎿
#         "remote")
#           git_status="%{$fg[red]%}⎿%f%{$fg[green]%}⏋%f "
#           ;;
#         "sync")
#           # git_status="S"
#           git_status="%{$fg[green]%}⎿%f%{$fg[green]%}⏋%f "
#           ;;
#         "remote-branch-not-exist")
#           git_status="%{$fg[green]%}⎿%f%{$fg[white]%}⏋%f "
#           ;;
#         "no-local-commits")
#           git_status="%{$fg[white]%}⎿%f "
#           ;;
#         "error")
#           git_status="%{$fg[red]%}E%f"
#           ;;
#         *)
#           git_status=""
#           ;;
#       esac

#     else
#     # Local repository without a remote named 'origin'
#     git_symbol="🖥️ "
#     git_status=""
#     fi

#   # In custom_theme.zsh-theme



#     echo "${git_symbol}${git_status}%{$fg[blue]%}⎇ %{$fg_bold[blue]%}(%{$reset_color%}${branch_color}${branch_name}%{$reset_color%}%{$fg_bold[blue]%})${reset_color}${state}%{\n%}"
#     # printf "%s%s%s" "${git_symbol}${git_status}%{$fg[blue]%}⎇ %{$fg_bold[blue]%}(%{$reset_color%}${branch_color}${branch_name}%{$reset_color%}%{$fg_bold[blue]%})${reset_color}${state}" $'\n'
#   fi
# }


# PROMPT='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
# PROMPT+='%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}- )${reset_color}'




# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

# # Apply custom style to the branch name
# # ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}⎇ (\033[37;41;5m" #the flashing causes the weird line behaviour
# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}⎇ (%{$fg[red]%}"
# # Reset the style before DIRTY and CLEAN
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}%{$fg[blue]%})%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗"
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# # ZSH_THEME_GIT_PROMPT_REMOTE="YES"
# ZSH_THEME_GIT_PROMPT_REMOTE="%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="%{$fg[yellow]%}"
# ZSH_THEME_GIT_PROMPT_SHOW_UPSTREAM="YES"




PROMPT="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_remote_status)$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}⎇ (%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%}✕"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})   "
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg[green]%}⎿%f%{$fg[red]%}⏋%f "
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg[red]%}⎿%f%{$fg[green]%}⏋%f "
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE="%{$fg[green]%}⎿%f%{$fg[green]%}⏋%f "
# ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[blue]%}⎿⏋"
# ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED="%{$fg[blue]%}⎿⏋"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}- "
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}* "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[yellow]%}r "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}del "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%}unmrg "


# ✗✭



# git_remote_status () {
# 	local remote ahead behind git_remote_status git_remote_status_detailed
# 	remote=${$(__git_prompt_git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/} 
# 	if [[ -n ${remote} ]]
# 	then
# 		ahead=$(__git_prompt_git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l) 
# 		behind=$(__git_prompt_git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l) 
# 		if [[ $ahead -eq 0 ]] && [[ $behind -eq 0 ]]
# 		then
# 			git_remote_status="$ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE" 
# 		elif [[ $ahead -gt 0 ]] && [[ $behind -eq 0 ]]
# 		then
# 			git_remote_status="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE" 
# 			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$((ahead))%{$reset_color%}" 
# 		elif [[ $behind -gt 0 ]] && [[ $ahead -eq 0 ]]
# 		then
# 			git_remote_status="$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE" 
# 			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$((behind))%{$reset_color%}" 
# 		elif [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]
# 		then
# 			git_remote_status="$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE" 
# 			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$((ahead))%{$reset_color%}$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$((behind))%{$reset_color%}" 
# 		fi
# 		if [[ -n $ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED ]]
# 		then
# 			git_remote_status="$ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX${remote:gs/%/%%}$git_remote_status_detailed$ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX" 
# 		fi
# 		echo $git_remote_status
# 	fi
# }


# git_prompt_status () {
# 	[[ "$(__git_prompt_git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]] && return
# 	local -A prefix_constant_map
# 	prefix_constant_map=('\?\? ' 'UNTRACKED' 'A  ' 'ADDED' 'M  ' 'ADDED' 'MM ' 'MODIFIED' ' M ' 'MODIFIED' 'AM ' 'MODIFIED' ' T ' 'MODIFIED' 'R  ' 'RENAMED' ' D ' 'DELETED' 'D  ' 'DELETED' 'UU ' 'UNMERGED' 'ahead' 'AHEAD' 'behind' 'BEHIND' 'diverged' 'DIVERGED' 'stashed' 'STASHED') 
# 	local -A constant_prompt_map
# 	constant_prompt_map=('UNTRACKED' "$ZSH_THEME_GIT_PROMPT_UNTRACKED" 'ADDED' "$ZSH_THEME_GIT_PROMPT_ADDED" 'MODIFIED' "$ZSH_THEME_GIT_PROMPT_MODIFIED" 'RENAMED' "$ZSH_THEME_GIT_PROMPT_RENAMED" 'DELETED' "$ZSH_THEME_GIT_PROMPT_DELETED" 'UNMERGED' "$ZSH_THEME_GIT_PROMPT_UNMERGED" 'AHEAD' "$ZSH_THEME_GIT_PROMPT_AHEAD" 'BEHIND' "$ZSH_THEME_GIT_PROMPT_BEHIND" 'DIVERGED' "$ZSH_THEME_GIT_PROMPT_DIVERGED" 'STASHED' "$ZSH_THEME_GIT_PROMPT_STASHED") 
# 	local status_constants
# 	status_constants=(UNTRACKED ADDED MODIFIED RENAMED DELETED STASHED UNMERGED AHEAD BEHIND DIVERGED) 
# 	local status_text
# 	status_text="$(__git_prompt_git status --porcelain -b 2> /dev/null)" 
# 	if [[ $? -eq 128 ]]
# 	then
# 		return 1
# 	fi
# 	local -A statuses_seen
# 	if __git_prompt_git rev-parse --verify refs/stash &> /dev/null
# 	then
# 		statuses_seen[STASHED]=1 
# 	fi
# 	local status_lines
# 	status_lines=("${(@f)${status_text}}") 
# 	if [[ "$status_lines[1]" =~ "^## [^ ]+ \[(.*)\]" ]]
# 	then
# 		local branch_statuses
# 		branch_statuses=("${(@s/,/)match}") 
# 		for branch_status in $branch_statuses
# 		do
# 			if [[ ! $branch_status =~ "(behind|diverged|ahead) ([0-9]+)?" ]]
# 			then
# 				continue
# 			fi
# 			local last_parsed_status=$prefix_constant_map[$match[1]] 
# 			statuses_seen[$last_parsed_status]=$match[2] 
# 		done
# 	fi
# 	for status_prefix in ${(k)prefix_constant_map}
# 	do
# 		local status_constant="${prefix_constant_map[$status_prefix]}" 
# 		local status_regex=$'(^|\n)'"$status_prefix" 
# 		if [[ "$status_text" =~ $status_regex ]]
# 		then
# 			statuses_seen[$status_constant]=1 
# 		fi
# 	done
# 	local status_prompt
# 	for status_constant in $status_constants
# 	do
# 		if (( ${+statuses_seen[$status_constant]} ))
# 		then
# 			local next_display=$constant_prompt_map[$status_constant] 
# 			status_prompt="$next_display$status_prompt" 
# 		fi
# 	done
# 	echo $status_prompt
# }




# git_prompt_info () {
# 	if ! __git_prompt_git rev-parse --git-dir &> /dev/null || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]
# 	then
# 		return 0
# 	fi
# 	local ref
# 	ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null)  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return 0
# 	local upstream
# 	if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} ))
# 	then
# 		upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null)  && upstream=" -> ${upstream}" 
# 	fi
# 	echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref:gs/%/%%}${upstream:gs/%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
# }








#  You can see the default / current settings for git_prompt_info(), git_remote_status(), git_prompt_status(), by running 'which git_prompt_info' in termainal


# Override the default git_prompt_info function to include, parse_git_branch_color
git_prompt_info() {
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]
  then
    return 0
  fi
  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null)  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return 0
  local upstream
  if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} ))
  then
    upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null)  && upstream=" -> ${upstream}" 
  fi
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}$(parse_git_branch_color "${ref}")${upstream:gs/%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

# Function to color the git branch based on its name
parse_git_branch_color() {
  local branch="$1"
  if [[ "$branch" == "main" ]]; then
    echo "‼️ %{$fg[red]%}${branch}‼️ %{$reset_color%}"
  elif [[ "$branch" == "dev" || "$branch" == "develop" || "$branch" == "development" ]]; then
    echo "%{$fg[magenta]%}${branch}%{$reset_color%}"
  elif [[ "$branch" == feature/* ]]; then
    echo "%{$fg[yellow]%}${branch}%{$reset_color%}"
  else
    echo "%{$fg[white]%}${branch}%{$reset_color%}"
  fi
}



# PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT+=' %{$fg[cyan]%}%c%{$reset_color%} $(git_remote_status)$(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

