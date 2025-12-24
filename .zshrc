#!/bin/zsh

# Define the .cache directory and create it if it doesn't exist
CACHE_DIR="${HOME}/.cache"

if [ ! -d "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
fi

# Put the ZCOMPDUMP in the cache directory to not clog up the home directory
ZSH_CACHE_DIR="${CACHE_DIR}/zsh"
ZSH_COMPDUMP="${ZSH_CACHE_DIR}/.zcompdump-${HOST}"

if [ ! -d "${ZSH_CACHE_DIR}" ]; then
    mkdir -p "${ZSH_CACHE_DIR}"
fi

(( ${fpath[(Ie)"${ZSH_CACHE_DIR}/completions"]} )) || fpath=("${ZSH_CACHE_DIR}/completions" $fpath)

# Define the local bin directory and create it if it doesn't exist.
LOCAL_BIN_DIR="${HOME}/.local/bin"

if [ ! -d "${LOCAL_BIN_DIR}" ]; then
  mkdir -p "${LOCAL_BIN_DIR}"
fi

# source .profile
source "${HOME}/.profile"

# fzf version and dl link
FZF_VER="0.6.7"
FZF_LINK="https://github.com/junegunn/fzf/releases/latest/download/fzf-${FZF_VER}-linux_amd64.tar.gz"

# Download fzf if it's not found
if [ ! -f "${LOCAL_BIN_DIR}/fzf" ]; then
   echo "fzf not found. Installing version ${FZF_VER} to ${LOCAL_BIN_DIR}/fzf"
   curl -sL https://github.com/junegunn/fzf/releases/download/v0.67.0/fzf-0.67.0-linux_amd64.tar.gz | tar zx -C ${LOCAL_BIN_DIR}
else
  echo "Found fzf at ${LOCAL_BIN_DIR}/fzf"
fi

# Download oh-my-posh if it's not found
if [ ! -f "${LOCAL_BIN_DIR}/oh-my-posh" ]; then
  echo "oh-my-posh not found. Installing to ${LOCAL_BIN_DIR}/oh-my-posh"
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "${LOCAL_BIN_DIR}"
else
  echo "Found oh-my-posh at ${LOCAL_BIN_DIR}/oh-my-posh"
fi

# Antigen location
export ADOTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/antigen"

# Only used by zsh internally, no need to export to environment.
ANTIGEN_COMPDUMP="${CACHE_DIR}/.acompdump-${HOST}"

# If Antigen is not installed, download it
if [ ! -d "${ADOTDIR}" ]; then
    echo "Installing Antigen to ${ADOTDIR}\n"
    mkdir -p "${ADOTDIR}"
    curl -L git.io/antigen > "${ADOTDIR}/antigen.zsh"
else
  echo "Found Antigen at ${ADOTDIR}"
fi

# Load Antigen
source "${ADOTDIR}/antigen.zsh"

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Add oh-my-zsh plugins
antigen bundle git
antigen bundle sudo
antigen bundle docker
antigen bundle docker-compose
antigen bundle command-not-found

# Add external plugins
antigen bundle Aloxaf/fzf-tab
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Apply staged Antigen plugins
antigen apply

# History settings
HISTSIZE=5000
HISTFILE="${ZSH_CACHE_DIR}/.zsh_history"
SAVEHIST=${HISTSIZE}

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Source fzf
source <(fzf --zsh)

eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config ${HOME}/.config/oh-my-posh/theme.json)"
