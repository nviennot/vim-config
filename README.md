Installation
=============

    cd ~
    git clone git://github.com/nviennot/vim-config.git .vim
    ln -s .vim/vimrc .vimrc
    ln -s .vim/gvimrc .gvimrc
    cp vimrc.mine.example vimrc.mine
    cp gvimrc.mine.example gvimrc.mine
    cd .vim
    cp vimrc.mine.example vimrc.mine
    cp gvimrc.mine.example gvimrc.mine
    git submodule init
    git submodule update


vimrc.mine and gvimrc.mine contain system-specific settings or other settings
that should not be part of a general configuration. Thus, they are not tracked
in the repo. My vimrc.mine and gvim.mine are included as examples.
