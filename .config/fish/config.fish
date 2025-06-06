fish_vi_key_bindings
starship init fish | source

#Pyenv
# Golang
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/golibs

# Abbreviations
abbr vi nvim
abbr gp git push
abbr ya yadm add
abbr yd "yadm diff -- . ':!*fish_variables' ':!*lazy-lock.json' ':!*raycast*'"
abbr yaa yadm add .
abbr ys yadm status
abbr yp yadm push
abbr ycm yadm commit -m
abbr nkk nvim /Users/bmikaili/.config/nvim/lua/config/keymaps.lua
abbr nkc nvim /Users/bmikaili/.config/nvim/lua/config/lazy.lua
abbr nko nvim /Users/bmikaili/.config/nvim/lua/config/options.lua
abbr nkp cd /Users/bmikaili/.config/nvim/lua/plugins/
abbr ac nvim /Users/bmikaili/.config/alacritty/alacritty.yml
abbr yc nvim /Users/bmikaili/.config/yabai/yabairc
abbr sc nvim /Users/bmikaili/.config/skhd/skhdrc
abbr fc nvim /Users/bmikaili/.config/fish/config.fish
abbr ish nvim /Users/bmikaili/install.sh
abbr fr source /Users/bmikaili/.config/fish/config.fish
abbr wc nvim /Users/bmikaili/.config/wezterm/wezterm.lua
abbr curl xh
abbr bi 'brew install'
abbr bu 'brew uninstall'
abbr bup 'brew update && brew upgrade'
abbr bci 'brew install --cask'
abbr bcu 'brew uninstall --cask'
abbr ls 'eza --icons --group-directories-first'
abbr ll 'eza --icons --group-directories-first -l'
abbr lt 'eza --icons --group-directories-first -T'
abbr la 'eza --icons --group-directories-first -a'
abbr lg lazygit
abbr j z
abbr '??' 'gh copilot explain'
abbr '!!' 'gh copilot suggest'
abbr cat bat
abbr find fd
abbr pn pnpm
abbr icloud '~/Library/Mobile\ Documents/com~apple~CloudDocs'
abbr java-21 'set -gx JAVA_HOME (/usr/libexec/java_home -v 21)'
abbr java-17 'set -gx JAVA_HOME (/usr/libexec/java_home -v 17)'
abbr bash_local_to_vm 'scp ~/.bashrc berzan:~/.bashrc'
abbr bash_vm_to_local 'scp berzan:~/.bashrc ~/.bashrc'
abbr cd z

set --export GOROOT "$(brew --prefix golang)/libexec"
fish_add_path $GOROOT/bin
fish_add_path $GOPATH/bin
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path /opt/homebrew/bin/wezterm
set -Ux LDFLAGS -L/opt/homebrew/opt/llvm/lib
set -Ux CPPFLAGS -I/opt/homebrew/opt/llvm/include

fzf --fish | source
zoxide init fish | source
eval "$(/opt/homebrew/bin/brew shellenv)"
