#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master
git submodule update --init --recursive

npm install -g eslint
npm install -g babel-eslint
npm install -g eslint-plugin-react
npm install -g typescript
npm install -g tslint

composer global require "squizlabs/php_codesniffer"

function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
