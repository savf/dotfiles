#!/bin/bash
# Inspired by https://github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh

dir=~/dotfiles
files="profile bashrc vimrc vim bin tmux.conf"

echo -n "Changing to the $dir directory for correct symlinks ... "
cd $dir
echo "done"

for file in $files; do
    echo "Creating symlink to $file in home directory"
    ln -s $dir/$file ~/.$file
done
