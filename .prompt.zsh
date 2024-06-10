precmd_conda_info() {
  if [[ -n $CONDA_PREFIX ]]; then
      if [[ $(basename $CONDA_PREFIX) == "anaconda3" ]]; then
        # Without this, it would display conda version. Change to miniconda3 if necessary
        CONDA_ENV="(base) "
      else
        # For all environments that aren't (base)
        CONDA_ENV="($(basename $CONDA_PREFIX)) "
      fi
  # When no conda environment is active, don't show anything
  else
    CONDA_ENV=""
  fi
}

# Display git branch
function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Run the previously defined function before each prompt
precmd_functions+=(precmd_conda_info)

# Define colors
COLOR_CON=$'%F{141}'
COLOR_DEF=$'%f'
COLOR_USR=$'%F{247}'
COLOR_DIR=$'%f'
COLOR_GIT=$'%F{215}'

# Allow substitutions and expansions in the prompt
setopt prompt_subst

PROMPT='${COLOR_CON}$CONDA_ENV${COLOR_USR}%n ${COLOR_DIR}%1~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}$ '
