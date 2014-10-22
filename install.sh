#!/bin/sh

# set up vars
notify() { echo "-----> $1"; }
info()   { echo "       $1"; }

notify "Doing stuff."

brew_ensure() {
	for pkg in "$@"; do
		if [[ -z $(brew list $pkg 2>/dev/null) ]]; then
			notify "Installing $pkg"
			brew install $pkg
		fi
	done
}

cask_ensure() {
	for pkg in "$@"; do
		if [[ ! $(brew cask list | grep $pkg) == "$pkg" ]]; then
			notify "Installing $pkg"
			brew cask install $pkg
		fi
	done
}

# configure .gitconfig
# from holman/dotfiles
if ! [ -f git/gitconfig.symlink ]; then
	notify "Configuring your .gitconfig"
	git_credential='osxkeychain'

	info "What is your git author name?"
	read -e git_authorname
	info "What is your git author email?"
	read -e git_authoremail

	sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.symlink.example > git/gitconfig.symlink
fi

# symlink dotfiles
notify "Linking dotfiles"
for file in $PWD/**/*.symlink; do
	link=$(echo $file | awk -F/ '{print $NF}' | sed -e 's/\.symlink//')
	# screw backups
	rm -f $HOME/.$link
	ln -s $file $HOME/.$link
done

# load zsh
if [[ $SHELL != $(which zsh) ]]; then
	notify "Changing shell to zsh"
	chsh -s $(which zsh)
fi

# update vundle
if [[ ! -d "$PWD/vim/vim.symlink/bundle/neobundle.vim" ]]; then
	notify "Installing Vundle"
	git clone https://github.com/Shougo/neobundle.vim $PWD/vim/vim.symlink/bundle/neobundle.vim
fi
notify "Updating Neobundle"
vim +NeoBundleInstall! +NeoBundleClean! +qall

# environment install

# install brew
if ! hash brew 2>/dev/null; then
	notify "Installing homebrew"
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
notify "Updating homebrew forumlas"
brew update

# install brew-cask
if [[ -z $(brew list | grep brew-cask) ]]; then
	notify "Installing homebrew cask"
	brew install caskroom/cask/brew-cask
	brew tap caskroom/versions
fi

cask_ensure anvil
cask_ensure dropbox
cask_ensure firefox
cask_ensure google-chrome-beta
cask_ensure induction
cask_ensure mou
cask_ensure sequel-pro
cask_ensure transmission
cask_ensure transmit
cask_ensure virtualbox
cask_ensure mailbox

# Git
brew_ensure git ghi

# Deps
brew_ensure gnu-sed pidof
brew_ensure automake autoconf curl pcre re2c mhash libtool icu4c gettext jpeg libxml2 mcrypt gmp libevent
if ! hash /usr/local/bin/icuinfo 2>/dev/null; then
	brew link icu4c
fi

# Tmux
brew_ensure tmux reattach-to-user-namespace

# Vim
brew_ensure macvim vim ctags the_silver_searcher

# MariaDB
if [[ -z $(brew list mariadb 2>/dev/null) ]]; then
	brew install mariadb
	unset TMPDIR
	mysql_install_db --user=`whoami` --basedir="$(brew --prefix mariadb)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
fi

# PostgreSQL
brew_ensure postgresql

# MongoDB
brew_ensure mongodb

# Redis
brew_ensure redis

# Ruby
brew_ensure rbenv ruby-build
if [[ -z $(rbenv versions | grep 1.9.3-p429) ]]; then
	notify "Setting up Ruby"
	rbenv install 1.9.3-p429
	rbenv global 1.9.3-p429
	gem install bundler capistrano-ext
fi;

# PHP
if [[ ! -d $HOME/.phpbrew ]]; then
	notify "Installing phpbrew"
	$PWD/bin/phpbrew init
fi
source $HOME/.phpbrew/bashrc
if [[ -z $(phpbrew list | grep php-5.4.20) ]]; then
	notify "Setting up PHP"
	phpbrew install php-5.4.20 +default +dbs
	pecl install mongo
	phpbrew ext enable mongo
	phpbrew switch php-5.4.20
fi

# Node.js
brew_ensure node

# Go-lang
brew_ensure go

# Python
# brew_ensure python

# Flash
# brew_ensure flex_sdk

# Android
# brew_ensure android-sdk

# Utils
brew_ensure grc htop-osx autoenv

# Heroku
brew_ensure heroku-toolbelt

#notify "Upgrading your brews"
#brew upgrade

notify "Loading OSX defaults"
$PWD/bin/osx-defaults

notify "👌  Success!"
