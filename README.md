# Dotfiles repository

Repository that contains portable dotfiles for use in any new GNU/Linux distribution.

## Requirements

The `.zshrc` will automatically install [fzf](https://github.com/junegunn/fzf), [oh-my-posh](https://ohmyposh.dev/) and [antigen](https://github.com/zsh-users/antigen) but requires some packages to do so:

```sh
sudo apt-get install curl unzip zip zsh
```

Might wanna `chsh` to zsh as well, obviously.

Ensure you have `git` and `stow` installed on your system to install the dotfiles to your system proper.

### Git

```sh
sudo apt-get install -y git
```

### Stow

```sh
sudo apt-get install -y stow
```

## Installation

Clone the dotfiles repository in your `$HOME` directory using git.

```sh
git clone https://github.com/raintje/dotfiles.git $HOME
cd dotfiles
```

Then use GNU stow to create symbolic links.

```sh
stow .
```
