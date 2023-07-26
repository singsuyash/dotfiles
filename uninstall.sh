brew uninstall --cask zoom
brew uninstall --cask microsoft-edge
brew uninstall ranger
brew uninstall httpstat
brew uninstall --cask visual-studio-code
brew uninstall ferdium
brew uninstall --cask drawio
brew uninstall colima
brew uninstall docker-compose
brew uninstall docker
brew uninstall speedtest
brew uninstall romkatv/powerlevel10k/powerlevel10k
brew uninstall --cask 1password/tap/1password-cli
brew uninstall fig
brew uninstall htop
brew uninstall tree
brew uninstall unzip
brew uninstall zip
brew uninstall zsh
brew uninstall neovim
brew uninstall pyenv
brew uninstall --cask iterm2

rm -rf /Applications/1Password.app
rm -rf /Applications/recordwithvideo.scpt
rm -rf $HOME/.fig
rm -rf $HOME/.fig.dotfiles.bak
rm -rf $HOME/.zshrc
rm -rf $HOME/.zprofile
rm -rf $HOME/.p10k.zsh
rm -rf $HOME/.vim
rm -rf $HOME/.vimrc
rm -rf $HOME/.personaltools
rm -rf $HOME/.vimrc.backup
rm -rf $HOME/.sdkman
rm -rf $HOME/.zsh
rm -rf $HOME/.npm
rm -rf $HOME/.nvm
rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.zshrc.pre-oh-my-zsh

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
rm -rf /opt/homebrew/*
