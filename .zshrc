source ~/.prompt.zsh

export TZ=US/Pacific

export VISUAL=lvim
export EDITOR="$VISUAL"
export PYTHONDONTWRITEBYTECODE=1 

alias clock='while true; do tput reset; date +"%H:%M:%S" | figlet -f epic; sleep 1; done'

export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="/Users/jhch/.local/bin:$PATH"
export PATH="/Users/jhch/.cargo/bin:$PATH"

NPM_PACKAGES="${HOME}/.npm-packages"


export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="/Users/jhch/.local/bin:$PATH"
export PATH="/Users/jhch/.cargo/bin:$PATH"


export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2022-03-22_at_15:02:54: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"

# Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/opt/homebrew/bin:$PATH"

 # Start: Run multiple Neovim distros
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvchad="NVIM_APPNAME=NvChad nvim"

 function nvims() {
  items=("default" "AstroNvim" "NvChad")
   config=$(printf "%s\n" "${items[@]}" | fzf --prompt="  Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
   if [[ -z $config ]]; then
     echo "Nothing selected"
     return 0
   elif [[ $config == "default" ]]; then
     config=""
   fi
   NVIM_APPNAME=$config nvim $@
 }
 # End: Run multiple Neovim distros

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jhch/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jhch/miniconda3/bin/conda" ]; then
        . "/Users/jhch/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jhch/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
