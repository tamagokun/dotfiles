#!/bin/sh
# cool intro
echo '       /$$             /$$             '
echo '      | $$            | $$             '
echo '  /$$$$$$$  /$$$$$$  /$$$$$$   /$$$$$$$'
echo ' /$$__  $$ /$$__  $$|_  $$_/  /$$_____/'
echo '| $$  | $$| $$  \ $$  | $$   |  $$$$$$ '
echo '| $$  | $$| $$  | $$  | $$ /$$\____  $$'
echo '|  $$$$$$$|  $$$$$$/  |  $$$$//$$$$$$$/'
echo ' \_______/ \______/    \___/ |_______/ '

# set up vars
notify() { echo "-----> $1"; }
info()   { echo "       $1"; }

package_ensure() {
	for pkg in "$@"; do
		if [[ -z $(dpkg -l | grep $pkg 2>/dev/null) ]]; then
			notify "Installing $pkg"
			sudo aptitude install -y $pkg
		fi
	done
}

# configure .gitconfig
# from holman/dotfiles
if ! [ -f git/gitconfig.symlink ]; then
	notify "Configuring your .gitconfig"
	git_credential='osxkeychain'

	user ' - What is your github author name?'
	read -e git_authorname
	user ' - What is your github author email?'
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

# update package index
sudo apt-get update

# Aptitude
if [[ -z $(dpkg -l | grep aptitude 2>/dev/null) ]]; then
	sudo apt-get install -y aptitude
fi

# Git
package_ensure git ghi

# Deps
package_ensure build-essential
package_ensure autoconf automake curl build-essential libxslt1-dev re2c libxml2-dev php5-cli bison libbz2-dev

sudo apt-get build-dep php5

# Tmux
package_ensure tmux

# Vim
package_ensure vim exuberant-ctags vim-gtk

# MariaDB
# if [[ -z $(brew list mariadb 2>/dev/null) ]]; then
# 	brew install mariadb
# 	unset TMPDIR
# 	mysql_install_db --user=`whoami` --basedir="$(brew --prefix mariadb)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
# fi

# PostgreSQL
package_ensure postgresql

# MongoDB
package_ensure mongodb

# Redis
package_ensure redis

# Ruby
if [[ ! -d "$HOME/.rbenv" ]]; then
	notify "Installing rbenv"
	git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
	git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

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
package_ensure npm

# Go-lang
package_ensure go

# Python
# package_ensure python

# Flash
# package_ensure flex_sdk

# Android
# package_ensure android-sdk

# Utils
package_ensure grc htop autoenv

# Heroku
if $(heroku &>/dev/null); then
	notify "Installing Heroku Toolbelt"
	wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi

notify "Upgrading packages"
sudo apt-get upgrade

notify "Success!"