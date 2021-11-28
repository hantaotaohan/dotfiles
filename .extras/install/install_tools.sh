#!/usr/bin/env bash

Dotfiles_repo=$(pwd)
Extras_dir=$(dirname "$PWD") 
#Extras_dir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd )
Bin_dir="$HOME/.bin"

#Git_clone="https://hub.fastgit.org"
#Git_download="https://download.fastgit.org"

#Git_clone="https://github.com"
#Git_download="https://github.com"

Git_clone="https://github.com.cnpmjs.org"
Git_download="https://github.com.cnpmjs.org"

#---------------------------------------------------------------------------------------------------------------------------------------
# Print usage message.
#---------------------------------------------------------------------------------------------------------------------------------------
usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF
Usage: $program_name [-option]
Options:
    
    -------------------------------------------------------------------------------
                                                                                   
         -h --help          Print this message                                                  
         -a --all           Setup All                                                           
         -m --minimize      Setup All   
         -s --server        Setup Server All                                                    
                                                                                   
    -------------------------------------------------------------------------------
        githubhosts         Config /etc/hosts/ View Github.com
        sshbanner           Config SSH Login Banner
        alttab              Same Windows Alt Tab
        arcthemes           Gtk themes
        arcicons            Gtk themes Icons
        githubssh           Settings Github.com SSH Key
        i3gaps              Setup I3-Gaps
        picom               Setup Picom
        dragon              Setup Ranger Plug Dragon
        dunst               Setup Dunst
        offlineimap         Auto Setting Neomutt
        navi                Setup Navi
        ctags               Setup Ctags
        rdrview             Setup Rdrview
        fixrofiicons        Settings Rofi Icons
        fixfzf              Fix FZF Ctrl + r
        imagemagick         Fix Imagemagick 
        jupyter             Setup Jupyter Notebook Settings Themes
        nodejs              Setup Node.js
        ssr                 Setup SSR
        calibre             Setup Calibre Settings Config
        foliate             Setup Foliate
        crossover           Setup Crossover Config Kindle
        copytranslator      Setup Copytranslator
        hugo                Setup Hugo
        java                Setup Java
        fsearch             Setup Fsearch
        clone               Git clone My github Respones
        ly                  Commandline Longin 
        fixvmwareshare      Fix Vmware Share Folads
        fixi3terminal       Fix I3wm Terminal Alacritty suppose
        fixnautilus         Fix Nautilus Views
        fzfopen             Setup FZF-Open of the New Alacritty
        i3blocks            Setup I3blocks
        yarn                Setup Yarn
        vim                 Setup Vim8.2
        bashdb              Setup Bashdb Bash debuger
        i3lock              Setup i3lock_fancy
        qutebrowser         Setup Qutebrowser
        weixin              Setup Weixin
        urxvt               Setup URxvt
        st                  Setup St terminal
        vifm                Setup Vifm

    -------------------------------------------------------------------------------
    
EOF
}

#---------------------------------------------------------------------------------------------------------------------------------------
# Public Functions . 
#---------------------------------------------------------------------------------------------------------------------------------------

row() {
    seq -s '─' 0 "$(tput cols)" | tr -d '[:digit:]'
}

#---------------------------------------------------------------------------------------------------------------------------------------
# Install Tools
#---------------------------------------------------------------------------------------------------------------------------------------

Alttab() {
    sudo apt install -y -qq libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev ibxpm-dev libxpm4 > /dev/null 2>&1 
    git clone -q $Git_clone/sagb/alttab.git $Bin_dir/alttab && cd $Bin_dir/alttab && ./configure > /dev/null 2>&1
    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1
    sudo rm -rf $Bin_dir/alttab
    row
    echo "Alttab installation is complete"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Arcthemes() {
    sudo apt install -y -qq arc-theme > /dev/null 2>&1
    row
    echo "The Arc Themes installation is complete"
    row
}

Arcicons() {
    cd "$Bin_dir" || return 
    git clone -q $Git_clone/horst3180/arc-icon-theme --depth 1 arc-icon-theme && cd arc-icon-theme > /dev/null 2>&1
    mkdir -p $HOME/.local/share/icons/
    cp -r Arc/ $HOME/.local/share/icons/
    cd $HOME
    sudo rm -rf $Bin_dir/arc-icon-theme
    row
    echo "The Arc Icons installation is complete"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Copytranslator() {
    wget -q -P $Bin_dir $Git_download/CopyTranslator/CopyTranslator/releases/download/v10.0.0-beta.2/copytranslator_10.0.0-beta.2_amd64.deb
    cd $Bin_dir
    sudo dpkg -i copytranslator_10.0.0-beta.2_amd64.deb  > /dev/null 2>&1
    sudo usermod -a -G input $USER
    cd $HOME
    sudo rm -rf $Bin_dir/copytranslator_10.0.0-beta.2_amd64.deb  > /dev/null 2>&1
    row
    Copytranslator Install Completed
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Crossover() {
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/crossover-20.deb
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/winewrapper.exe.so
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/kindle.zip
    sudo dpkg -i $Bin_dir/crossover-20.deb
    sudo apt install -f -y -qq
    sudo dpkg -i $Bin_dir/crossover-20.deb
    sudo mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
    sudo cp $Bin_dir/winewrapper.exe.so /opt/cxoffice/lib/wine/
    cd $HOME
    sudo rm -rf $Bin_dir/winewrapper.exe.so crossover-20.deb
    sudo dpkg --add-architecture i386 && \
    sudo apt-get update -y -qq && \
    sudo apt-get install -y -qq gstreamer1.0-plugins-base:i386 \
    gstreamer1.0-plugins-good:i386 \
    gstreamer1.0-plugins-ugly:i386 \
    libc6-i386 \
    libcups2:i386 \
    libdbus-1-3:i386 \
    libfontconfig1:i386 \
    libfreetype6:i386 \
    libgl1-mesa-dri:i386 \
    libgl1-mesa-glx:i386 \
    libglu1-mesa:i386 \
    libgnutls30:i386 \
    libgstreamer1.0-0:i386 \
    libldap-2.4-2:i386 \
    libpng16-16:i386 \
    libsane:i386 \
    libudev1:i386 \
    libvulkan1:i386 \
    libx11-6:i386 \
    libxcomposite1:i386 \
    libxcursor1:i386 \
    libxext6:i386 \
    libxfixes3:i386 \
    libxi6:i386 \
    libxinerama1:i386 \
    libxml2:i386 \
    libxrandr2:i386 \
    libxrender1:i386 \
    libxslt1.1:i386 \
    libxxf86vm1:i386
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
I3gaps() {
    cd "$Bin_dir" || return 
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/i3gaps.zip
    unzip -q i3gaps.zip
    sudo dpkg -i i3gpas1.deb > /dev/null 2>&1
    sudo dpkg -i i3gpas2.deb > /dev/null 2>&1
    sudo dpkg -i i3gpas3.deb > /dev/null 2>&1
    sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
    sed -i 's|# smart_gaps on|smart_gaps on|g' $HOME/.config/i3/config
    sed -i 's|# gaps inner 8|gaps inner 8|g' $HOME/.config/i3/config
    sed -i 's|# gaps outer 2|gaps outer 2|g' $HOME/.config/i3/config
    sed -i 's|# smart_gaps inverse_outer|smart_gaps inverse_outer|g' $HOME/.config/i3/config
    row
    echo "I3 - Gaps Install Completed"
    row
    rm -rf i3gaps* i3gpas*
}

#---------------------------------------------------------------------------------------------------------------------------------------
Imagemagick() {
    sudo apt install -y -qq imagemagick
    if [ -f /etc/ImageMagick-6/policy.xml ]; then
        sudo sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
    fi
    row
    Imagemagick Fix Completed
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Jupyter() {
    sudo pip3 install -q --timeout 1000 --retries 20 ipython notebook prompt-toolkit -i https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null 2>&1
    if [ ! -d "$HOME/.jupyter/custom/" ]
    then
        mkdir -p $HOME/.jupyter/custom/
        cp $Extras_dir/jupyter/custom.css $HOME/.jupyter/custom/custom.css
    fi

    if [ ! -d "$HOME/.ipython/profile_default/startup/" ]
    then
        mkdir -p $HOME/.ipython/profile_default/startup/
        cp $Extras_dir/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py
    fi
    row
    jupyter --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Navi() {
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/navi
    sudo mv $Bin_dir/navi /usr/local/bin
    if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        ln -fs $Extras_dir/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    else
        mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
        ln -fs $Extras_dir/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    fi
    sudo chmod +x /usr/local/bin/navi
    row
    navi -V
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
#Picom() {
#    sudo apt install -y -qq libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev \
#    libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev \
#    libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev \
#    meson  > /dev/null 2>&1
#    git clone -q $Git_clone/yshui/picom.git  $Bin_dir/picom
#    cd $Bin_dir/picom
#    git submodule update --init --recursive > /dev/null 2>&1
#    meson --buildtype=release . build > /dev/null 2>&1
#    sudo ninja -C build > /dev/null 2>&1
#    sudo ninja -C build install > /dev/null 2>&1
#    cd $HOME
#    sudo rm -rf $Bin_dir/picom
#    sed -i "s|# exec --no-startup-id picom --config ~/.config/picom/picom.conf|exec --no-startup-id picom --config ~/.config/picom/picom.conf|g" $HOME/.config/i3/config
#    sed -i "s|exec --no-startup-id compton --config ~/.config/compton/compton.conf|# exec --no-startup-id compton --config ~/.config/compton/compton.conf|g" $HOME/.config/i3/config
#    row
#    echo "Picom Version: "picom --version
#    row
#}

Picom() {
    sudo apt install -y -qq libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev \
    libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev \
    libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev \
    meson  > /dev/null 2>&1
    git clone -q $Git_clone/yshui/picom.git  $Bin_dir/picom
    cd $Bin_dir/picom
    rm -rf build
    git submodule update --init  > /dev/null 2>&1
    meson --buildtype=release . build -Dwith_docs=false  > /dev/null 2>&1
    ninja -C build  > /dev/null 2>&1
    sudo install -Dm755 --verbose build/src/picom /usr/local/bin/picom > /dev/null 2>&1
    row
    echo "Picom Version: "picom --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
SSR() {
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/electron-ssr.deb
    sudo dpkg -i $Bin_dir/electron-ssr.deb  > /dev/null 2>&1
    sudo apt install -f -y > /dev/null 2>&1
    sudo dpkg -i $Bin_dir/electron-ssr.deb  > /dev/null 2>&1
    cd $HOME
    sudo rm -rf $Bin_dir/electron-ssr.deb
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Dunst() {
    sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev > /dev/null 2>&1
    git clone -q $Git_clone/dunst-project/dunst.git $Bin_dir/dunst
    cd $Bin_dir/dunst
    sudo make  > /dev/null 2>&1
    sudo make install  > /dev/null 2>&1
    cd $HOME
    rm -rf $Bin_dir/dunst
    row
    dunst -v
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Offlineimap() {
    echo "It Is Now Being Configured Offlineimap ...... "
    echo "Please Enter The Zip Package Password "
    unzip -q -d $HOME/.config/neomutt/ $HOME/.config/neomutt/user.pass
    if ! [ -f /etc/systemd/user/offlineimap.service ]; then
        sudo cp $Extras_dir/offlineimap/offlineimap.service /etc/systemd/user
        systemctl --user enable offlineimap
        systemctl --user start offlineimap
    else
        sudo rm -rf /etc/systemd/user/offlineimap.service
        sudo cp $Extras_dir/offlineimap/offlineimap.service /etc/systemd/user
        systemctl --user daemon-reload
        systemctl --user enable offlineimap
        systemctl --user start offlineimap
    fi
    sudo chmod 600 $HOME/.msmtprc
    row
    echo "Neomutt Config Doen! "
    neomutt -v | grep -o -E "NeoMutt [1-9]\d*.\d*.\d*.\d*.\d*..."
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Github_SSH() {
    if ! [ -f $HOME/.ssh/id_rsa.pub ]; then
        echo 'Please Input Email Addrsses For SSH Key'
        read -e ssh_email
        ssh-keygen -t rsa -P "" -C "$ssh_email"  -f ~/.ssh/id_rsa
        echo 'Key copied to keyboard'
        xclip -sel clip < $HOME/.ssh/id_rsa.pub
        microsoft-edge --new-window 'https://github.com/settings/keys'
    else
        echo 'Key copied to keyboard'
        xclip -sel clip < $HOME/.ssh/id_rsa.pub
        microsoft-edge --new-window 'https://github.com/settings/keys'
    fi
    row
    echo "Add Github For SSH Key Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Github_Hosts() {
    #sudo sed -i '/# GitHub/,$d' /etc/hosts
    sudo sed -i '$a\# ------------------------------------------------------------------' /etc/hosts
    sudo python3 $Extras_dir/autohosts/github_hosts.py
    row
    tail -n -3 /etc/hosts 
    echo ""
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Vmware_Share_Fix() {
    if type vmhgfs-fuse >/dev/null 2>&1; then
        sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other,nonempty ;
    fi
}

#---------------------------------------------------------------------------------------------------------------------------------------
Calibre() {
    sudo apt install calibre -y -qq >/dev/null 2>&1
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/calibre.zip
    unzip -d $HOME/.config/ $Bin_dir/calibre.zip
    git clone $Git_clone/hantaotaohan/books $HOME/books
    row
    echo "Install Calibre Done & Calibre Config Done & Git Clone Book Done"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Foliate() {
    sudo snap install foliate
}

#---------------------------------------------------------------------------------------------------------------------------------------
Rdrview() {
    sudo apt install -y -qq libxml2-dev libseccomp-dev libcurl4-gnutls-dev > /dev/null 2>&1
    git clone -q $Git_clone/eafer/rdrview.git $Bin_dir/rdrview
    cd $Bin_dir/rdrview
    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1
    cd $HOME
    rm -rf $Bin_dir/rdrview
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
SSH_banner() {
    sudo sed -i '$a\Banner \/etc\/ssh\/my_ssh_banner' /etc/ssh/sshd_config
    sudo cp $Extras_dir/banner/my_ssh_banner /etc/ssh/
    systemctl restart sshd
    row
    echo "SSH Banner Replacement Is Complete"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Ly() {
    sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
    git clone $Git_clone/nullgemm/ly.git $HOME/desktop/ly
    cd $HOME/desktop/ly
    make github
    make
    sudo make install
    sudo systemctl enable ly.service
    cd $HOME
    rm -rf $HOME/desktop/ly
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Ctags() {
    sudo apt purge --remove ctags > /dev/null 2>&1
    sudo apt install -y -qq libjansson-dev autotools-dev autoconf > /dev/null 2>&1
    git clone -q $Git_clone/universal-ctags/ctags.git --depth=1 $Bin_dir/ctags
    cd $Bin_dir/ctags
    ./autogen.sh > /dev/null 2>&1
    ./configure > /dev/null 2>&1
    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1
    cd $HOME
    rm -rf $Bin_dir/ctags
    row
    ctags --version | grep "Universal Ctags"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Nodejs() {
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt install -y -qq nodejs > /dev/null 2>&1
    row
    node --version
    row
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -y -qq yarn > /dev/null 2>&1
    sudo rm -rf /etc/apt/sources.list.d/yarn.list
    row
    yarn --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Hugo() {
    wget -q $Git_download/gohugoio/hugo/releases/download/v0.79.1/hugo_extended_0.79.1_Linux-64bit.deb -O $Bin_dir/hugo.deb
    cd $Bin_dir
    sudo dpkg -i hugo.deb
    cd $HOME
    rm -rf $Bin_dir/hugo.deb
    row
    hugo version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Java() {
    sudo apt install -y -qq default-jre
    sudo apt install -y -qq default-jdk
    row
    java -version
    row
    javac -version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fix_FZF_history() {
    echo "bind -m emacs-standard '\"\\C-r\": \"\\C-e \\C-u\\C-y\\ey\\C-u\"\$(__fzf_history__)\"\\e\\C-e\\er\\C-m\"'" >> $HOME/.fzf/shell/key-bindings.bash
    row
    echo "Fix FZF History Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Clone() {
    #git clone git@github.com:hantaotaohan/vimwiki.git $HOME/vimwiki
    #git clone git@github.com:hantaotaohan/hantaotaohan.github.io.git $HOME/blog
    #git clone git@github.com:hantaotaohan/books.git $HOME/books
    git clone git@github.com:hantaotaohan/logseq.git $HOME/logseq
    row
    echo "Git Clone Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fixrofiicons() {
    sudo sed -i '$a\Icon=/home/taotao/debian/.extras/icons/pdf.png' /usr/share/applications/org.pwmt.zathura.desktop
    sudo sed -i '$a\Icon=/home/taotao/debian/.extras/icons/mail.png' /usr/share/applications/neomutt.desktop 
    sudo sed -i '$a\Icon=/home/taotao/debian/.extras/icons/translate.png' /usr/share/applications/copytranslator.desktop
    sudo sed -i '$a\Icon=/home/taotao/debian/.extras/icons/browser.png' /usr/share/applications/ranger.desktop
    # fix ranger open path
    sudo sed -i '$a\Exec=/home/taotao/.config/ranger/ranger-oepn %U' /usr/share/applications/ranger.desktop
    row
    echo "Fix Rofi Icons Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fixi3terminal() {
    if [ -f /usr/bin/i3-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/rofi-sensible-terminal
    fi
    if [ -f /usr/bin/rofi-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/i3-sensible-terminal
    fi
    row
    echo "I3wm Terminal for Alacritty Doen!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Dragon() {
    git clone -q $Git_clone/mwh/dragon $Bin_dir/dragon && cd $Bin_dir/dragon > /dev/null 2>&1
    make  > /dev/null 2>&1
    make install  > /dev/null 2>&1
    cd $HOME
    rm -rf $Bin_dir/dragon
    row
    dragon --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fearch() {
    sudo apt install git build-essential automake autopoint autoconf libtool pkg-config intltool autoconf-archive libpcre3-dev libglib2.0-dev libgtk-3-dev libxml2-utils
    git clone -q $Git_clone/cboxdoerfer/fsearch.git $Bin_dir/fsearch && cd $Bin_dir/fsearch > /dev/null 2>&1
    ./autogen.sh
    ./configure
    make && sudo make install
    cd $HOME
    rm -rf $Bin_dir/fsearch
    row
    fsearch --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fixnautilus() {
    # 隐藏边栏
    # gsettings set org.gnome.nautilus.window-state start-with-sidebar false
    # 显示边栏
    # gsettings set org.gnome.nautilus.window-state start-with-sidebar true
    
    # 输入栏
    # gsettings set org.gnome.nautilus.preferences always-use-location-entry true
    # 路径栏
    # gsettings set org.gnome.nautilus.preferences always-use-location-entry false
    
    # 删除文件和清空回收站有确认框
    # gsettings set org.gnome.nautilus.preferences confirm-trash true
    # 删除文件和清空回收站没有有确认框
    # gsettings set org.gnome.nautilus.preferences confirm-trash false
    
    # 可供选择的值有“list-view”(列表视图)和“icon-view”(图标视图)
    gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
    gsettings set org.gnome.nautilus.preferences show-image-thumbnails "'never'"
    gsettings set org.gnome.nautilus.preferences show-directory-item-counts "'never'"
    gsettings set org.gnome.nautilus.preferences recursive-search 'never'
    gsettings set org.gtk.Settings.FileChooser sort-directories-first 'true'
    gsettings set org.gtk.Settings.FileChooser show-hidden 'true'
    gsettings set org.gnome.desktop.wm.preferences audible-bell 'false'
    row
    echo "fix Nautilus Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fzfopen() {
    git clone -q $Git_clone/hantaotaohan/fzf-open.git $Bin_dir/fzf-open > /dev/null 2>&1
    cd $Bin_dir/fzf-open
    sudo ./install.sh
    sed '/^Terminal=/d;s/^Exec=/Exec=alacritty -e /' /usr/share/applications/ranger.desktop > ~/.local/share/applications/ranger.desktop
    cd ..
    rm -rf fzf-open
    row
    echo "FZF-OPEN Install Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
I3blocks() {
    git clone -q $Git_clone/vivien/i3blocks $Bin_dir/i3blocks > /dev/null 2>&1
    cd $Bin_dir/i3blocks
    ./autogen.sh > /dev/null 2>&1
    ./configure > /dev/null 2>&1
    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1
    cd ..
    rm -rf i3blocks
    row
    i3blocks -V
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Yarn() {
    sudo apt remove yarn
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update -y -qq && sudo apt install -y -qq yarn
    row
    yarn -v
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Vim() {
    sudo apt-get remove --purge vi vim-tiny vim vim-runtime gvim vim-common vim-gui-common vim-nox
    sudo apt-get install libncurses5-dev python-dev python3-dev libwxgtk3.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/vim8.2.deb
    cd $Bin_dir
    sudo dpkg -i vim8.2.deb  > /dev/null 2>&1
    sudo apt install -f > /dev/null 2>&1
    sudo dpkg -i vim8.2.deb  > /dev/null 2>&1
    cd $HOME
    sudo rm -rf $Bin_dir/vim8.2.deb  > /dev/null 2>&1
    row
    Vim8.2 Install Completed
    vim --version | head -1
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Bashdb() {
    wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/bashdb.tar.gz
    cd $Bin_dir
    tar -zxvf bashdb.tar.gz
    cd bashdb-5.0-1.1.2
    ./configure
    make
    sudo make install
    row
    echo "BASHDB Install Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
I3lock() {
    git clone -q $Git_clone/meskarune/i3lock-fancy.git $Bin_dir/i3lock-fancy > /dev/null 2>&1
    cd $Bin_dir/i3lock-fancy
    sudo make install
    cd $Bin_dir
    rm -rf i3lock-fancy
    row
    echo "I3lock-Fancy Install Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Qutebrowser() {
    sudo apt install qutebrowser
    if [ -d "$HOME/.local/share/qutebrowser/greasemonkey/" ]; then
        cp $HOME/.config/qutebrowser/greasemonkey/* $HOME/.local/share/qutebrowser/greasemonkey/
    else
        mkdir -p $HOME/.local/share/qutebrowser/greasemonkey
        cp $HOME/.config/qutebrowser/greasemonkey/* $HOME/.local/share/qutebrowser/greasemonkey/
    fi
    row
    qutebrowser -V | head -16 | grep qutebrowser
    row

#---------------------------------------------------------------------------------------------------------------------------------------
    # sudo apt install python3-venv
    # git clone -q $Git_clone/qutebrowser/qutebrowser.git $Bin_dir/qutebrowser > /dev/null 2>&1
    # cd $Bin_dir/qutebrowser
    # python3 scripts/mkvenv.py
    # mkdir releases
    # cd releases
    # echo '#!/bin/bash' >> qutebrowser
    # echo '$HOME/.bin/qutebrowser/.venv/bin/python3 -m qutebrowser "$@"' >> qutebrowser
    # sudo chmod +x qutebrowser
    # sudo cp qutebrowser /usr/local/bin/qutebrowser
    # sudo cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so $HOME/.bin/qutebrowser/.venv/lib/python3.7/site-packages/PyQt5/Qt5/plugins/platforminputcontexts/
    # row
    # $Bin_dir/qutebrowser/.venv/bin/python3 -m qutebrowser -V | head -16 | grep qutebrowser
    # row
}

Weixin() {
    wget -q -P $Bin_dir http://archive.ubuntukylin.com/software/pool/partner/ukylin-wine_70.6.3.25_amd64.deb 
    wget -q -P $Bin_dir http://archive.ubuntukylin.com/software/pool/partner/ukylin-wechat_3.0.0_amd64.deb 
    cd $Bin_dir
    sudo apt-get install -f -y ./ukylin-wine_70.6.3.25_amd64.deb
    sudo apt-get install -f -y ./ukylin-wechat_3.0.0_amd64.deb
    row
    echo "Weixin Install Done!"
    row
}

Urxvt() {
    sudo apt install libperl-dev
    wget -q -P $Bin_dir http://dist.schmorp.de/rxvt-unicode/rxvt-unicode-9.26.tar.bz2 
    cd $Bin_dir
    tar -xvf rxvt-unicode-9.26.tar.bz2
    cd rxvt-unicode-9.26
    ./configure --enable-xft --enable-font-styles --enable-iso14755 --enable-unicode3 --enable-256-color --with-x
    row
    urxvt --version 2>&1 | grep rxvt-unicode
    row
}

St() {
    cd "$Bin_dir" || return 
    git clone -q $Git_clone/hantaotaohan/st --depth 1 st && cd st > /dev/null 2>&1
    sudo make clean install
    row
    st -v
    row
}

Vifm() {
    sudo apt install vifm
    pip3 install -q --timeout 1000 --retries 20 ueberzug -i https://pypi.tuna.tsinghua.edu.cn/simple
    cd "$Bin_dir" || return
    git clone -q $Git_clone/hantaotaohan/vifmimg --depth 1 vifmimg && cd vifmimg > /dev/null 2>&1
    sudo make install
    row
    echo "Vifm - Vifmimg Install Done !"
    row
}

main() {

    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        alttab)
            Alttab
            ;;
        arcthemes)
            Arcthemes
            ;;
        arcicons)
            Arcicons
            ;;
        copytranslator)
            Copytranslator
            ;;
        crossover)
            Crossover
            ;;
        i3gaps)
            I3gaps
            ;;
        imagemagick)
            Imagemagick
            ;;
        jupyter)
            Jupyter
            ;;
        navi)
            Navi
            ;;
        picom)
            Picom
            ;;
        ssr)
            SSR
            ;;
        dunst)
            Dunst
            ;;
        offlineimap)
            Offlineimap
            ;;
        githubssh)
            Github_SSH
            ;;
        githubhosts)
            Github_Hosts
            ;;
        fixvmwareshare)
            Vmware_Share_Fix
            ;;
        calibre)
            Calibre
            ;;
        foliate)
            Foliate
            ;;
        rdrview)
            Rdrview
            ;;
        sshbanner)
            SSH_banner
            ;;
        ly)
            Ly
            ;;
        ctags)
            Ctags
            ;;
        nodejs)
            Nodejs
            ;;
        hugo)
            Hugo
            ;; 
        java)
            Java
            ;;
        fixfzf)
            Fix_FZF_history
            ;;
        clone)
            Clone
            ;;  
        fixrofiicons)
            Fixrofiicons
            ;;
        fixi3terminal)
            Fixi3terminal
            ;;
        dragon)
            Dragon
            ;;   
        fixnautilus)
            Fixnautilus
            ;;
        fzfopen)
            Fzfopen
            ;;
        i3blocks)
            I3blocks
            ;;
        yarn)
            Yarn
            ;;
        vim)
            Vim
            ;;
        bashdb)
            Bashdb
            ;;
        i3lock)
            I3lock
            ;;
        qutebrowser)
            Qutebrowser
            ;;
        weixin)
            Weixin
            ;;
        urxvt)
            Urxvt
            ;;
        st)
            St
            ;;
        vifm)
            Vifm
            ;;   
        -a|--all)
            Github_Hosts
            Alttab
            Arcthemes
            Arcicons
            #I3gaps
            Picom
            Dunst
            Offlineimap
            Navi
            #Ctags
            Rdrview
            Fixrofiicons
            #Fix_FZF_history
            #Fixi3terminal
            #Imagemagick
            #Jupyter
            #Nodejs
            #SSR
            #Calibre
            #Foliate
            #Crossover
            #Copytranslator
            #Hugo
            #Java
            Github_SSH
            Clone
            Dragon
            #Ly
            Vmware_Share_Fix
            SSH_banner
            Fixnautilus
            Fzfopen
            Vim
            I3lock
            Bashdb
            Qutebrowser
            #I3blocks
            #Yarn
            ;;
        -m|--minimize)
            Github_Hosts
            Alttab
            Arcthemes
            Arcicons
            I3gaps
            Picom
            Dunst
            Offlineimap
            Navi
            Ctags
            Rdrview
            Fixrofiicons
            Fix_FZF_history
            Fixi3terminal
            #Imagemagick
            Dragon
            Github_SSH
            SSH_banner
            Fixnautilus
            Fzfopen
            I3blocks
            I3lock
            Bashdb
            ;;
        -s|--server)
            Github_Hosts
            Offlineimap
            Navi
            Ctags
            Rdrview
            Fix_FZF_history
            #Imagemagick
            Jupyter
            Nodejs
            Hugo
            Java
            Clone
            Github_SSH
            SSH_banner
            Bashdb
            ;;             
        *)
            echo "Command not found" >&2
    esac
}

main "$@"
