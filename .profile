#!/bin/zsh

export EDITOR="vim"
export SHELL="zsh"
export BROWSER="firefox"

# nvm
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
export NVM_COMPLETION=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=("zed", "nvim")

# pnpm
export PNPM_HOME="${HOME}/.local/bin"

# Aliases
alias c="clear"

export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.local/bin/pnpm"
