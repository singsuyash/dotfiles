
grant_access() {
    sudo chown -R $(whoami) /usr/local/Homebrew /usr/local/etc/bash_completion.d /usr/local/lib/pkgconfig /usr/local/share/aclocal /usr/local/share/doc /usr/local/share/info /usr/local/share/locale /usr/local/share/man/man3 /usr/local/share/man/man5 /usr/local/share/man/man7 /usr/local/share/man/man8 /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks /usr/local/var/log
    chmod u+w /usr/local/Homebrew /usr/local/etc/bash_completion.d /usr/local/lib/pkgconfig /usr/local/share/aclocal /usr/local/share/doc /usr/local/share/info /usr/local/share/locale /usr/local/share/man/man3 /usr/local/share/man/man5 /usr/local/share/man/man7 /usr/local/share/man/man8 /usr/local/share/zsh /usr/local/share/zsh/site-functions /usr/local/var/homebrew/locks /usr/local/var/log
}

install_homebrew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/suyash/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

install_zsh() {
    brew install zsh
    chsh -s /opt/homebrew/bin/zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_powerlevel10k() {
	brew install romkatv/powerlevel10k/powerlevel10k
	echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc
}

# zsh autosuggestions
install_zsh_autosuggestions() {
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
    echo 'source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh'>>~/.zshrc
}

# zsh syntax highlighting
install_zsh_syntax_highlighting() {
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
    echo 'source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh'>>~/.zshrc
}

install_pyenv() {
    brew install pyenv
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
}

install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
}

install_fig() {
    brew install fig
    fig login
    fig
}

install_1password() {
    current_directory=$(pwd)
    mkdir temp
    cd temp
    curl https://downloads.1password.com/mac/1Password.zip --output 1Password.zip
	unzip 1Password.zip
	open 1Password\ Installer.app
    sleep 20
    cd ..
    rm -rf temp
    cd $current_directory
}

install_sdkman() {
    curl -s "https://get.sdkman.io" | bash
}

install_ookla_speed_test() {
    brew tap teamookla/speedtest
    brew update
    brew install speedtest --force
}

install_record_av() {
    cp ./recordwithvideo.scpt /Applications/
}

[ -n "$(which brew)" ] && grant_access
[ -z "$(which brew)" ] && install_homebrew
[ -z "$(which pyenv)" ] && install_pyenv
[ -z "$(which python3)" ] && pyenv install 3.10.4
[ -z "$(which git)" ] && brew install git
[ -z "$(which nvim)" ] && brew install neovim
[ -z "$(which zsh)" ] && install_zsh
[ -z "$(which zip)" ] && brew install zip
[ -z "$(which unzip)" ] && brew install unzip
[ -z "$(which tree)" ] && brew install tree 
[ -z "$(which htop)" ] && brew install htop 
[ -z "$(whereis nvm)" ] && install_nvm
[ -z "$(which node)" ] && nvm install node
[ -z "$(which fig)" ] && install_fig
[ -z "$(ls /Applications | grep 1Password.app)" ] && install_1password
[ -z "$(which op)" ] && brew install --cask 1password/tap/1password-cli
[ -z "$(brew ls --versions powerlevel10k)" ] && install_powerlevel10k
[ -z "$(ls ~/.zsh/ | grep zsh-autosuggestions)" ] && install_zsh_autosuggestions
[ -z "$(ls ~/.zsh/ | grep zsh-syntax-highlighting)" ] && install_zsh_syntax_highlighting
[ -z "$(whereis sdk)" ] && install_sdkman
[ -z "$(which speedtest)" ] && install_ookla_speed_test
[ -z "$(ls /Applications | grep recordwithvideo)" ] && install_record_av
[ -z "$(which docker)" ] && brew install docker
[ -z "$(which docker-compose)" ] && brew install docker-compose
[ -z "$(which colima)" ] && brew install colima 
[ -z "$(ls /Applications | grep draw.io.app)" ] && brew install --cask drawio
[ -z "$(ls /Applications | grep Ferdium.app)" ] && brew tap ferdium/ferdium && brew install ferdium
[ -z "$(which code)" ] && brew install --cask visual-studio-code
[ -z "$(which httpstat)" ] && brew install httpstat
[ -z "$(which ranger)" ] && brew install ranger
[ -z "$(ls /Applications | grep Microsoft\ Edge)" ] && brew install microsoft-edge
[ -z "$(ls /Applications | grep zoom.us.app)" ] && brew install --cask zoom

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

echo "Setup 1Password app, then integrate with 1password cli, visit https://developer.1password.com/docs/cli/get-started"
echo restart terminal
echo
