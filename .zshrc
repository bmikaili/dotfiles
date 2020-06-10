# This is my ZSH configuration

# Exports {{{
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export VISUAL=nvim
export EDITOR="$VISUAL"
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export SSH_KEY_PATH="~/.ssh/rsa_id"
fpath=(path/to/zsh-completions/src $fpath)

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

 # # Base16 Shell
# BASE16_SHELL="$HOME/.config/base16-shell/"
# [ -n "$PS1" ] && \
 #    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
 #        eval "$("$BASE16_SHELL/profile_helper.sh")"

# }}}

# General ZSH configuration {{{
# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Fix for autocompletion coloring
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

# }}}

# Plugins {{{
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         osx
         zsh-completions
         zsh-syntax-highlighting
         zsh-autosuggestions
         zsh-history-substring-search
         autojump
         docker
         docker-compose
         gradle
         cp
         gitignore
         kubectl

         tmux)


source $ZSH/oh-my-zsh.sh
prompt_context() {}
# }}}

# Keybinds {{{
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
#}}}

# Aliases {{{
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias zshrc="nvim ~/.zshrc"
alias vim="nvim"
alias vi="nvim"
alias ls="exa"
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias s="sudo "
alias alacritty="vi ~/.config/alacritty/alacritty.yml"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/"
alias tmuxconf="vi ~/.tmux.conf"
alias td="tmux detach"
alias find="fd"
alias tsd="terminal-scheme dark"
alias tsl="terminal-scheme light"
# }}}

# Functions {{{
function terminal-scheme() {
  config_file=~/.config/alacritty/alacritty.yml
  sed -i "" "s/\(^colors: \*\).*/\1$1/g" $config_file
}
# }}}

# Fix for pasting with autosuggestions {{{
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# }}}

# Fuzzy finder configuration {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
# }}}

# Themes {{{
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
# }}}

# Gcloud {{{
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/berzanmikaili/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/berzanmikaili/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/berzanmikaili/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/berzanmikaili/google-cloud-sdk/completion.zsh.inc'; fi
# }}}

# Conda {{{
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# }}}

# Completions {{{
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi
# }}}
<<<<<<< HEAD

# Datadog {{{
# BEGIN ANSIBLE MANAGED BLOCK
# Add homebrew binaries to the path.
export PATH="/usr/local/bin:${PATH?}"

# Force certain more-secure behaviours from homebrew
export HOMEBREW_NO_INSECURE_REDIRECT=1
export HOMEBREW_CASK_OPTS=--require-sha

# Load ruby shims
eval "$(rbenv init -)"

# Prefer GNU binaries to Macintosh binaries.
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"

# Add AWS CLI to PATH
export PATH="/usr/local/opt/awscli@1/bin:$PATH"

# Add datadog devtools binaries to the PATH
export PATH="${HOME?}/dd/devtools/bin:${PATH?}"

# Point GOPATH to our go sources
export GOPATH="${HOME?}/go"

# Point DATADOG_ROOT to ~/dd symlink
export DATADOG_ROOT="${HOME?}/dd"

# Tell the devenv vm to mount $GOPATH/src rather than just dd-go
export MOUNT_ALL_GO_SRC=1

# store key in the login keychain instead of aws-vault managing a hidden keychain
export AWS_VAULT_KEYCHAIN_NAME=login

# tweak session times so you don't have to re-enter passwords every 5min
export AWS_SESSION_TTL=24h
export AWS_ASSUME_ROLE_TTL=1h

dd-branch(){git checkout -b berzan/$1}
# END ANSIBLE MANAGED BLOCK
# }}}
=======
>>>>>>> cbbe0314ca0378c3c8ccc9ebee7781edf7e22972
