# Put the ZCOMPDUMP in the cache directory to not clog up the home directory
export ZSH_COMPDUMP="${HOME}/.cache/.zcompdump-${HOST}"
export ZSH_CACHE_DIR="${HOME}/.cache"

if [ ! -d "$ZSH_CACHE_DIR" ]; then
    mkdir -p "$ZSH_CACHE_DIR/completions"
fi

(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

# source .profile
source "${HOME}/.profile"

# Antigen path
ADOTDIR="${XDG_DATA_HOME:-$HOME/.local/share}/antigen"
ANTIGEN_COMPDUMP=$ZSH_COMPDUMP
 
# If Antigen is not installed, download it
if [ ! -d "$ADOTDIR" ]; then
    mkdir -p "$ADOTDIR"
    curl -L git.io/antigen > "${ADOTDIR}/antigen.zsh"
fi

# Load Antigen
source "${ADOTDIR}/antigen.zsh"

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Load the oh-my-zsh plugins
antigen bundle git
antigen bundle sudo
antigen bundle docker
antigen bundle docker-compose
antigen bundle command-not-found

# Load external plugins
antigen bundle Aloxaf/fzf-tab
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting

# Apply Antigen bundles
antigen apply

# History
HISTSIZE=5000
HISTFILE="${HOME}/.cache/.zsh_history"
SAVEHIST=$HISTSIZE
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
source "${HOME}/.fzf.zsh"

eval "$(fzf --zsh)"
eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/theme.toml)"
