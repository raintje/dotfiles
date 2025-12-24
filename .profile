#!/bin/zsh

export EDITOR="zed"
export SHELL="zsh"
export BROWSER="zen"

# nvm
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=("zed", "nvim")

# Aliases
alias c="clear"
alias z="zed ."

export PATH="${PATH}:${HOME}/.local/bin"
