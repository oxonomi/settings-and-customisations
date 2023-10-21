# custom_theme.zsh-theme

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}- )"
PROMPT+='%{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'

git_prompt_info() {
  local ref
  ref=$(git symbolic-ref HEAD 2>/dev/null) || return 0
  local branch_name="${ref#refs/heads/}"

  # branch styles
  if [ -n "$branch_name" ]; then
    # default = white
    local branch_color="%{$fg[white]%}"
    # main = blinking red
    if [[ "$branch_name" == "main" ]]; then
    local branch_color="\033[37;41;5m"
    # dev, develop, development = purple
    elif [[ "$branch_name" == "dev" || "$branch_name" == "develop" || "$branch_name" == "development" ]]; then
    local branch_color="%{$fg[magenta]%}"
    # feature/ = yellow
    elif [[ "$branch_name" == feature/* ]]; then
      branch_color="%{$fg[yellow]%}"
    fi

    # if dirty tree; contains changes
    local dirty_color="%{$fg[yellow]%}"
    local state=" "
    if [[ -n $(git status -s 2> /dev/null) ]]; then
      state="${dirty_color}✧%f "
    fi

    local git_symbol=""
    if [[ $(git remote | grep -c 'origin') -gt 0 ]]; then
      local origin_url=$(git remote get-url origin)
      if [[ $origin_url == *"github.com"* ]]; then
        # GitHub-connected repository with GitHub logo
        git_symbol="☁️ "
        # git_symbol="😺" # or if you want Github to be a cat
      else
        # Local repository with an 'origin' remote, but not GitHub
        git_symbol="🔗"
      fi
    else
    # Local repository without a remote named 'origin'
    git_symbol=""
    fi
    

    echo "${git_symbol}%{$fg[blue]%}⎇ %{$fg_bold[blue]%}(%{$reset_color%}${branch_color}${branch_name}%{$reset_color%}%{$fg_bold[blue]%})${reset_color}${state}"
  fi
}
