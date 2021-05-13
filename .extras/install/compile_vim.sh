#!/bin/bash

git clone https://hub.fastgit.org/vim/vim.git $HOME/.bin/vim
cd $HOME/.bin/vim
sudo apt-get remove --purge vi vim-tiny vim vim-runtime gvim vim-common vim-gui-common vim-nox
sudo apt-get install libncurses5-dev python-dev python3-dev libwxgtk3.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
sudo ./configure --with-features=huge \
	--enable-multibyte \
	--enable-fontset \
	--enable-rubyinterp \
	--enable-pythoninterp \
	--enable-python3interp \
	--enable-luainterp \
	--enable-cscope \
	--enable-gui=auto \
	--enable-perlinterp \
	--with-python-config-dir=$(python2-config --configdir) \
	--with-python3-config-dir=$(python3-config --configdir) \
	--with-compiledby="TaoTao" \
	--enable-largefile \
	--prefix=/usr/local
sudo make
sudo make install
cd $HOME
sudo rm -rf $HOME/.bin/vim

# --with-features=huge：支持最大特性
# --enable-rubyinterp：打开对 ruby 编写的插件的支持
# --enable-pythoninterp：打开对 python 编写的插件的支持
# --enable-python3interp：打开对 python3 编写的插件的支持
# --enable-luainterp：打开对 lua 编写的插件的支持
# --enable-perlinterp：打开对 perl 编写的插件的支持
# --enable-multibyte：打开多字节支持，可以在 Vim 中输入中文
# --enable-cscope：打开对cscope的支持
# --enable-gui=gtk3 表示生成采用 GNOME3 风格的 gvim
# --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu/ 指定 python 路径
# --with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu/ 指定 python3路径
# --prefix=/usr/local/vim：指定将要安装到的路径
