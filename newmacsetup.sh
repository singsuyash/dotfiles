current_directory=$(pwd)

mkdir installationtemp

# vim
brew install vim

# homebrew
if [ -z "$(which brew)" ]
then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/suyash/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
else
    brew update
	echo "homebrew already installed"
	echo
fi

# terminal beautification
# oh my zsh
if [ -z "$(which zsh)" ]
then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
	echo "zsh is already installed"
	echo
fi

# powerlevel10k, a zsh theme
if [ -z "$(brew ls --versions powerlevel10k)" ]
then
	brew install romkatv/powerlevel10k/powerlevel10k
	echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
else
	echo "powerlevel10k is already installed"
	echo
fi

# zsh autosuggestions
if [ -z "$(ls ~/.zsh/ | grep zsh-autosuggestions)" ]
then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh'>>~/.zshrc
else
    echo "zsh autosuggestions is already installed"
fi

# zsh syntax highlighting
if [ -z "$(ls ~/.zsh/ | grep zsh-syntax-highlighting)" ]
then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
    echo 'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'>>~/.zshrc
else
    echo "zsh syntax highlighting is already installed"
fi

# copy vimrc
if [ -n "$(ls -halt ~/ | grep vimrc)" ]
then
	mv ~/.vimrc ~/.vimrc.backup
	cp ./.vimrc ~/.
else
	cp ./.vimrc ~/.
fi

# copy personaltools
if [ -z "$(ls -halt ~/ | grep personaltools)" ]
then
    cp .personaltools ~/.
    echo "source ~/.personaltools" >> ~/.zshrc
else
    echo "personal tools are already installed"
fi

# pyenv
if [ -z "$(which pyenv)" ]
then
    brew install pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
else
    echo "pyenv is already installed"
    echo
fi

# python3
if [ -z "$(which python3)" ]
then
    pyenv install 3.10.4
else
    echo "python3 is already installed"
fi

# nvm
if [ -z "$(which nvm)" ]
then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
else
    echo "nvm is already installed"
fi

if [ -z "$(which node)" ]
then
    nvm install node
else
    echo "node is already installed"
fi

# utilities
if [ -z "$(which zip)" ]
then
	brew install zip
else
	echo "zip already installed"
	echo
fi

if [ -z "$(which unzip)" ]
then
	brew install unzip
else
	echo "unzip already installed"
	echo
fi

if [ -z "$(which tree)" ]
then
	brew install tree
else
	echo "tree already installed"
	echo
fi

if [ -z "$(which fig)" ]
then
	brew install fig
	fig login
	fig
else
	echo "fig already installed"
	echo
fi

# 1password
if [ -z "$(ls /Applications | grep 1Password.app)" ]
then
	cd installationtemp
	curl https://downloads.1password.com/mac/1Password.zip --output 1Password.zip
	unzip 1Password.zip
	open 1Password\ Installer.app
	cd $HOME
else
	echo "1Password app already installed"
	echo
fi

if [ -z "$(which op)" ]
then
	brew install --cask 1password/tap/1password-cli
else
	echo "1Password cli already installed"
	echo
fi



rm -r installationtemp
cd $current_directory

echo "Setup 1Password app, then integrate with 1password cli, visit https://developer.1password.com/docs/cli/get-started"
echo restart terminal
echo
