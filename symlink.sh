#!/usr/bin/env bash
# Inspired by https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh

dir=~/dotfiles
files="profile bashrc vimrc vim bin tmux.conf lessfilter"

echo -n "Changing to the $dir directory for correct symlinks ... "
cd $dir
echo "done"

for file in $files; do
	echo "Removing existing dotfiles from ~"
	rm -rf ~/.$file
done

if [ ! -f ~/.aliases ]
then
	echo "Creating empty .aliases file and symlink"
	touch ~/dotfiles/aliases
	ln -s ~/dotfiles/aliases ~/.aliases
fi

for file in $files; do
    echo "Creating symlink to $file in home directory"
    ln -s $dir/$file ~/.$file
done
