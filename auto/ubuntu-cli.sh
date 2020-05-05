#!/bin/sh

# sets up a cli ubuntu development environment

# install packages
sudo apt install neovim tmux ranger stow python3

# checkout only the necessary subdirectories from my repository
mkdir dotfiles
cd dotfiles
git init
git remote add -f origin
git config core.sparseCheckout true

# install oh-my-zsh
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# pass only necessary paths
# https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository#13738951
echo "ranger/" >> .git/info/parse-checkout
echo "vim/" >> .git/info/parse-checkout
echo "nvim/" >> .git/info/parse-checkout
echo "tmux/" >> .git/info/parse-checkout

# fetch everything
git pull origin master

# unstow configurations
stow ranger
stow vim
stow nvim
stow tmux

cd ..

# refresh installation
# nvim -E -s -u "~/.vimrc" +PlugInstall +qall
nvim --headless +PlugInstall +qall

# zsh is default shell
sudo chsh -s $(which zsh)
source .zshrc
