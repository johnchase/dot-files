# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bash_profile.pre.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.pre.bash"
#20200205_1 Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";
export TZ=US/Pacific
# Tell OSX not to complain about bash
export BASH_SILENCE_DEPRECATION_WARNING=1
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,git-completion.bash,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

export VISUAL=lvim
export EDITOR="$VISUAL"
export PYTHONDONTWRITEBYTECODE=1 


alias clock='while true; do tput reset; date +"%H:%M:%S" | figlet -f epic; sleep 1; done'
# alias vim="nvim"
# alias vi="nvim"
# alias oldvim="vim"
alias fix_pg="rm /usr/local/var/postgres/postmaster.pid"
alias kpyc="find . -name '*.pyc' -exec rm -f {} \;"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/johnchase/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/johnchase/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/johnchase/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/johnchase/Downloads/google-cloud-sdk/completion.bash.inc'; fi
eval "$(/opt/homebrew/bin/brew shellenv)"export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


NPM_PACKAGES="${HOME}/.npm-packages"


export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="/Users/jhch/.local/bin:$PATH"
export PATH="/Users/jhch/.cargo/bin:$PATH"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# Fig post block. Keep at the bottom of this file.



##
# Your previous /Users/jhch/.bash_profile file was backed up as /Users/jhch/.bash_profile.macports-saved_2022-03-22_at_15:02:54
##

# MacPorts Installer addition on 2022-03-22_at_15:02:54: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2022-03-22_at_15:02:54: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jhch/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jhch/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jhch/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jhch/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bash_profile.post.bash" ]] && builtin source "$HOME/.fig/shell/bash_profile.post.bash"
