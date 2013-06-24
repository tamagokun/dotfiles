# cool intro

# set up vars
function notify { echo "-----> $1"; }
function info   { echo "       $1"; }

function brew_ensure {
	for pkg in "$@"; do
		if [[ -z $(brew list $pkg 2>/dev/null) ]]; then
			notify "Installing $pkg"
			brew install $pkg
		fi
	done
}

function cask_ensure {
	for pkg in "$@"; do
		if [[ ! $(brew cask list | grep $pkg) == "$pkg" ]]; then
			notify "Installing $pkg"
			brew cask install $pkg
		fi
	done
}

# symlink dotfiles
notify "Linking dotfiles"
for file in $PWD/**/*.symlink; do
	link=$(echo $file | awk -F/ '{print $NF}' | sed -e 's/\.symlink//')
	rm $HOME/.$link
	ln -s $file $HOME/.$link
done

# load zsh
if [[ $SHELL != $(which zsh) ]]; then
	notify "Changing shell to zsh"
	chsh `which zsh`
fi

# update vundle
if [[ ! -d "$PWD/vim/vim.symlink/bundle/vundle" ]]; then
	notify "Installing Vundle"
	git clone https://github.com/gmarik/vundle.git $PWD/vim/vim.symlink/bundle/vundle
fi
notify "Updating vundle bundles"
vim +BundleInstall! +BundleClean! +qall

# environment install

# install brew
if ! hash brew 2>/dev/null; then
	notify "Installing homebrew"
	ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
fi
notify "Updating homebrew"
brew update
brew cleanup

# install brew-cask
if [[ -z $(brew list | grep brew-cask) ]]; then
	notify "Installing homebrew cask"
	brew tap phinze/homebrew-cask
	brew install brew-cask
fi

cask_ensure alfred
cask_ensure anvil
cask_ensure dropbox
cask_ensure firefox
cask_ensure google-chrome
cask_ensure induction
cask_ensure mou
cask_ensure sequel-pro
cask_ensure transmission
cask_ensure transmit
cask_ensure virtualbox
cask_ensure xtra-finder
# Need Formulae
# -------------------
# iterm2 (beta)
# google-chrome (beta)
# mongohub
# twitterific

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
brew_ensure macvim vim ctags

# MariaDB
brew_ensure mariadb

# PostgreSQL
brew_ensure postgresql

# MongoDB
brew_ensure mongodb

# Redis
brew_ensure redis

# Ruby
notify "Setting up Ruby"
brew_ensure rbenv ruby-build
if [[ -z $(rbenv versions | grep 1.9.3-p429) ]]; then
	rbenv install 1.9.3-p429
fi;
rbenv global 1.9.3-p429
gem install bundler capistrano-ext

# PHP
notify "Setting up PHP"
if [[ ! -d $HOME/.phpbrew ]]; then
	notify "Installing phpbrew"
	$PWD/bin/phpbrew init
fi
source $HOME/.phpbrew/bashrc
if [[ -z $(phpbrew list | grep php-5.4.16) ]]; then
	phpbrew install php-5.4.16 +default +dbs
	pecl install mongo
	phpbrew ext enable mongo
fi
phpbrew switch php-5.4.16

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
brew_ensure grc htop-osx

notify "Upgrading your brews"
brew upgrade

notify "👌  Success!"