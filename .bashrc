
RED="\[\033[0;31m\]"
BRIGHT_YELLOW="\[\033[1;33m\]"
YELLOW="\[\033[0;33m\]"
BRIGHT_GREEN="\[\033[1;32m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_BLUE="\[\033[1;34m\]"
COLOR_NONE="\[\e[0m\]"
 
function parse_git_branch {
  git rev-parse --git-dir &> /dev/null
  git_status="$(git status 2> /dev/null)"
  branch_pattern="^# On branch ([^${IFS}]*)"
  remote_pattern="# Your branch is (.*) (of|by)"
  diverge_pattern="# Your branch and (.*) have diverged"
  
  if [[ ! ${git_status}} =~ "working directory clean" ]]; then
    state="${LIGHT_RED}?"
  fi
 
  if [[ ${git_status} =~ ${remote_pattern} ]]; then
    if [[ ${BASH_REMATCH[1]} == "ahead" ]]; then
      remote="${YELLOW}?"
    else
      remote="${YELLOW}?"
    fi
  fi
 
  if [[ ${git_status} =~ ${diverge_pattern} ]]; then
    remote="${YELLOW}?"
  fi
 
  if [[ ${git_status} =~ ${branch_pattern} ]]; then
    branch=${BASH_REMATCH[1]}
    echo " (${branch})${remote}${state}"
  fi
}
 
function prompt_func() {
  PS1="${COLOR_NONE}[${BRIGHT_YELLOW}\w${BRIGHT_GREEN}$(parse_git_branch)${COLOR_NONE}]> "
}
 
PROMPT_COMMAND=prompt_func

