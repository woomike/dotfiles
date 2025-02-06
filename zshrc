# easy vim open
alias nvim=~/nvim-macos-x86_64/bin/nvim
alias vim=~/nvim-macos-x86_64/bin/nvim

# autocomplete case insensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
autoload -Uz compinit && compinit
