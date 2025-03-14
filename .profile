export EDITOR=nvim
export SHELL=zsh

# nvm
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('code', 'nvim')
export NVM_AUTO_USE=true
export NVM_COMPLETION=true

# composer
export COMPOSER_HOME="$HOME/.local/share/composer"

alias c="clear"

export PATH="$PATH:$COMPOSER_HOME/vendor/bin:$HOME/.local/bin"
