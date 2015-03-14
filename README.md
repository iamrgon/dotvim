# dotvim
rgon's .vim files

Installation:

    git clone git://github.com/iamrgon/dotvim.git ~/.vim

Create symlinks:

    ln -s ~/.vim/vimrc ~/.vimrc

Switch to the `~/.vim` directory, and fetch submodules:

    cd ~/.vim
    git submodule update --init

To upgrade bundled plugins:

    git submodule foreach git pull origin master


