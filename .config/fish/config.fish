fish_vi_key_bindings

#Pyenv
pyenv init - | source

# Golang
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/golibs

# Abbreviations
abbr vi nvim
abbr ya yadm add
abbr yaa yadm add .
abbr ys yadm status
abbr yp yadm push
abbr ycm yadm commit -m
abbr nkc nvim /Users/berzanmikaili/.config/nvim/lua/config/keymaps.lua
abbr nkp cd /Users/berzanmikaili/.config/nvim/lua/plugins/
abbr ac nvim /Users/berzanmikaili/.config/alacritty/alacritty.yml
abbr yc nvim /Users/berzanmikaili/.config/yabai/yabairc
abbr sc nvim /Users/berzanmikaili/.config/skhd/skhdrc
abbr fc nvim /Users/berzanmikaili/.config/fish/config.fish
abbr fr source /Users/berzanmikaili/.config/fish/config.fish
abbr tc nvim /Users/berzanmikaili/.config/tmux/tmux.conf
abbr ta tmux attach
abbr td tmux detach
abbr wc nvim /Users/berzanmikaili/.config/wezterm/wezterm.lua
abbr gp 'git push --no-verify'
abbr bi 'brew install'
abbr bu 'brew uninstall'
abbr bup 'brew update && brew upgrade'
abbr bci 'brew install --cask'
abbr bcu 'brew uninstall --cask'
abbr ls 'exa --icons --group-directories-first'
abbr ll 'exa --icons --group-directories-first -l'
abbr lt 'exa --icons --group-directories-first -T'
abbr la 'exa --icons --group-directories-first -a'
abbr lg lazygit
abbr j z
abbr '??' 'gh copilot explain'
abbr '!!' 'gh copilot suggest'
abbr cat bat
abbr find fd
abbr pn pnpm

fish_add_path $GOROOT/bin
fish_add_path $GOPATH/bin
fish_add_path /opt/homebrew/opt/llvm/bin
set -Ux LDFLAGS -L/opt/homebrew/opt/llvm/lib
set -Ux CPPFLAGS -I/opt/homebrew/opt/llvm/include

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
