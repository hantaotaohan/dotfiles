#!/usr/bin/env bash

#---------------------------------------------------------------------------------------------------------------------------------------
# Define Variable.
#---------------------------------------------------------------------------------------------------------------------------------------

# Set Mail Password
PASSWORD=""

# Basis Define Variable
BIN_DIR="$HOME/.bin"
EXTRAS_DIR=$(dirname "$PWD") 
APT_INSTALL="sudo apt install -qq -y"
DOTFILES_REPO=$(pwd)

# Line Scheme "Github"
# GIT_CLONE="git clone -q https://github.com"
# GIT_DOWNLOAD="https://github.com"

# Line Scheme "Fastgit"
# GIT_CLONE="git clone -q https://hub.fastgit.org"
# GIT_DOWNLOAD="https://download.fastgit.org"

# Line Scheme "Cnpmjs"
GIT_CLONE="git clone -q https://github.com.cnpmjs.org"
GIT_DOWNLOAD="https://github.com.cnpmjs.org"

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
        alttab              Install Program Alttab - Same Windows Alt Tab
        anki                Install Program Anki
        arcicons            Install Gtk Dark-themes Icons
        bashdb              Install Program Bashdb Bash Debug Tools
        ctags               Install Program  News Version Universal-Ctags 
        clone               Git Clone Need SSH-KEY Is My Github Respones
        calibre             Install Program Calibre And Settings Config
        dunst               Install Program Dunst - X11 Message Tools
        dragon              Install Ranger Plug Dragon - Ranger Drop Function
        fixfzf              Fix Fzf Of Ctrl+r History Enter Direct Execution
        foliate             Install Program Foliate - eBook Reader
        fixnautilus         Fix Nautilus Views Mode
        fixrofiicons        Fix Rofi Icons - Add Other Icons
        fixi3terminal       Fix I3wm Terminal Alacritty Suppose
        fixvmwareshare      Settings Vmware Share Folads
        githubhosts         Settings Config /etc/hosts/ Uses Fast View Github.com
        githubssh           Settings Github.com SSH Key - Auto SSH_Ras Copy
        hugo                Install Program Hugo
        i3gaps              Install Program I3gaps
        i3blocks            Install Program I3blocks
        i3lockfancy         Install Program i3lock_fancy
        imagemagick         Fix Imagemagick - Convert Pdf Normally
        java                Install Program Java
        jupyter             Install Program Jupyter Notebook And Settings Themes
        ly                  Install Program Ly Commandline Longin 
        navi                Install Program Navi - Cheatsheet Tools
        nodejs              Install Program Node.js
        offlineimap         Install Program offlineimap -  Auto Setting Neomutt
        picom               Install Program Picom
        popupdict           Install Program Popupdict - Translate Tools
        qutebrowser         Install Program Qutebrowser - Web Browser
        rdrview             Install Program Rdrview - HTML Render Tools
        st                  Install Program St - Terminal
        sshbanner           Settings SSH Login Banner
        urxvt               Install Program URxvt - Terminal
        vim                 Install Program Vim Version 8.2
        vifm                Install Program Vifm - FileBrowser
        weixin              Install Program Weixin - Linux Weixin
        yarn                Install Program Yarn

    -------------------------------------------------------------------------------
    
EOF

}

#---------------------------------------------------------------------------------------------------------------------------------------
# Public Tools Functions . 
#---------------------------------------------------------------------------------------------------------------------------------------

row() {
    seq -s '─' 0 "$(tput cols)" | tr -d '[:digit:]'
}

#---------------------------------------------------------------------------------------------------------------------------------------
# Install Tools
#---------------------------------------------------------------------------------------------------------------------------------------

Alttab() {

    ${APT_INSTALL} libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev libxpm-dev libxpm4 > /dev/null 2>&1
    
    cd ${BIN_DIR} || return

    if [ -d "alttab" ]; then 
        cd alttab && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/sagb/alttab && cd alttab 
    fi

    ./configure > /dev/null 2>&1 
    make > /dev/null 2>&1 
    sudo make install > /dev/null 2>&1

    row
    echo -e "Alttab Install Is Complete :: Version "  $(alttab -v 2>&1 | grep -i 'alttab' | head -n 1 | sed -e "s/\b\(.\)/\u\1/g" )
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Arcicons() {

    cd ${BIN_DIR} || return

    if [ -d "arc-icon-theme" ]; then 
        cd arc-icon-theme && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/horst3180/arc-icon-theme && cd arc-icon-theme 
    fi

    if [ ! -d "$HOME/.local/share/icons/" ]; then
        mkdir -p $HOME/.local/share/icons/
    fi

    cp -rf Arc/ $HOME/.local/share/icons/

    row
    echo "The Arc Icons installation is complete"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Imagemagick() {

    ${APT_INSTALL} imagemagick > /dev/null 2>&1

    if [ -f /etc/ImageMagick-6/policy.xml ]; then
        sudo sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
    fi

    row
    echo "Imagemagick Fix Completed"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Jupyter() {

    pip3 install -q --timeout 1000 --retries 20 ipython notebook prompt-toolkit -i https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null 2>&1

    if [ ! -d "$HOME/.jupyter/custom/" ]; then
        mkdir -p $HOME/.jupyter/custom/
    fi

    cp $EXTRAS_DIR/jupyter/custom.css $HOME/.jupyter/custom/custom.css

    if [ ! -d "$HOME/.ipython/profile_default/startup/" ]; then
        mkdir -p $HOME/.ipython/profile_default/startup/
    fi

    cp $EXTRAS_DIR/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py

    row
    echo -e "Jupyter Install Is Complete :: Version "  $( jupyter --version | grep -iE "ipython|notebook" | sed -e "s/\b\(.\)/\u\1/g" )
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Navi() {

    cd ${BIN_DIR} || return

    wget -q $GIT_DOWNLOAD/hantaotaohan/dotfiles/releases/download/1.0.0/navi

    sudo cp $BIN_DIR/navi /usr/local/bin

    if [ ! -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
    fi

    ln -fs $EXTRAS_DIR/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat

    sudo chmod +x /usr/local/bin/navi

    row
    echo -e "Navi Install Is Complete :: Version "  $( navi -V | sed -e "s/\b\(.\)/\u\1/g" )
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Picom() {

    ${APT_INSTALL} libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev > /dev/null 2>&1
    ${APT_INSTALL} libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev  > /dev/null 2>&1
    ${APT_INSTALL} libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev > /dev/null 2>&1
    ${APT_INSTALL} libevdev-dev uthash-dev libev-dev libx11-xcb-dev  libxcb-present-dev > /dev/null 2>&1
    ${APT_INSTALL} libxcb-xinerama0-dev libxcb-glx0-dev libxcb-render-util0-dev meson > /dev/null 2>&1

    cd ${BIN_DIR} || return

    if [ -d "picom" ]; then 
        cd picom && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/yshui/picom && cd picom 
    fi

    rm -rf build
    git submodule update --init > /dev/null 2>&1
    meson --buildtype=release . build -Dwith_docs=false > /dev/null 2>&1
    ninja -C build > /dev/null 2>&1
    sudo install -Dm755 --verbose build/src/picom /usr/local/bin/picom > /dev/null 2>&1

    row
    echo "Picom Install Is Complete :: Version: " $(picom --version | sed -e "s/\b\(.\)/\u\1/g")
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Dunst() {

    cd ${BIN_DIR} || return

    ${APT_INSTALL} libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev > /dev/null 2>&1
    ${APT_INSTALL} libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev > /dev/null 2>&1

    if [ -d "dunst" ]; then 
        cd dunst && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/dunst-project/dunst && cd dunst 
    fi

    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1

    row
    echo "Dunst Install Is Complete :: Version: " $(dunst -v | sed -e "s/\b\(.\)/\u\1/g")
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Offlineimap() {

    # row
    # echo "Please enter the password to extract the package: ......  "
    # row

    # row
    # unzip -o -q -d $HOME/.config/neomutt/ $HOME/.config/neomutt/user.pass
    # row

    cd $HOME/.config/neomutt/
    gpg --quiet --batch --yes --passphrase=$PASSWORD --output alimail.pass --decrypt alimail.pass.gpg
    gpg --quiet --batch --yes --passphrase=$PASSWORD --output hotmail.pass --decrypt hotmail.pass.gpg

    if [ -f /etc/systemd/user/offlineimap.service ]; then
        sudo rm -rf /etc/systemd/user/offlineimap.service
    fi

    sudo cp $EXTRAS_DIR/offlineimap/offlineimap.service /etc/systemd/user

    systemctl --user daemon-reload
    systemctl --user enable offlineimap
    systemctl --user start offlineimap

    sudo chmod 600 $HOME/.msmtprc
    
    if [ -d $HOME/mail/ ]; then
        touch $HOME/mail/Postponed
    fi

    row
    echo "Neomutt Install Is Complete :: Version: " $(neomutt -v | grep -o -E "NeoMutt [1-9]\d*.\d*.\d*.\d*.\d*...")
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Github_SSH() {

    if ! [ -f $HOME/.ssh/id_rsa.pub ]; then
        row
        echo "Please Input Email Addrsses For SSH Key: ...... "
        row
        read -e ssh_email
        ssh-keygen -t rsa -P "" -C "$ssh_email"  -f ~/.ssh/id_rsa  > /dev/null 2>&1
    fi

    row
    echo 'Key Copied to keyboard'
    row

    xclip -sel clip < $HOME/.ssh/id_rsa.pub
    microsoft-edge --new-window 'https://github.com/settings/keys' > /dev/null 2>&1

    row
    echo "Add Github For SSH Key Done!"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Github_Hosts() {

    sudo python3 $EXTRAS_DIR/autohosts/github_hosts.py

    row
    echo "Github Hosts Install Is Complete :: Update Time: " $(tail -n -4 /etc/hosts  | head -n 1)
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Vmware_Share_Fix() {

    if type vmhgfs-fuse >/dev/null 2>&1; then
        sudo vmhgfs-fuse .host:/ /mnt/hgfs -o allow_other,nonempty ;
    fi

    row
    echo "Vmware Share Tools is Enable"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Calibre() {

    cd ${BIN_DIR} || return

    ${APT_INSTALL} calibre > /dev/null 2>&1

    $GIT_CLONE/hantaotaohan/books $HOME/books

    row
    echo "Calibre Install Is Complete  & Git Clone Book Done :: Version: " $(calibre --version | sed -e "s/\b\(.\)/\u\1/g")
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Foliate() {

    cd ${BIN_DIR} || return

    wget -q $GIT_DOWNLOAD/hantaotaohan/dotfiles/releases/download/1.0.0/foliate.deb
    sudo dpkg -i foliate.deb > /dev/null 2>&1

    row
    echo "Foliate Install Is Complete :: Version: " $(com.github.johnfactotum.Foliate -v)
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Rdrview() {

    cd ${BIN_DIR} || return

    ${APT_INSTALL} libxml2-dev libseccomp-dev libcurl4-gnutls-dev > /dev/null 2>&1

    if [ -d "rdrview" ]; then 
        cd rdrview && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/eafer/rdrview && cd rdrview 
    fi

    make > /dev/null 2>&1 
    sudo make install > /dev/null 2>&1

    row
    echo -e "Rerview Install Is Complete :: Version "  $(rdrview -v | sed -e "s/\b\(.\)/\u\1/g" )
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------

SSH_banner() {

    sudo sed -i '$a\Banner \/etc\/ssh\/my_ssh_banner' /etc/ssh/sshd_config
    sudo cp $EXTRAS_DIR/banner/my_ssh_banner /etc/ssh/

    # systemctl restart sshd

    row
    echo "SSH Banner Replacement Is Complete"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Ly() {

    cd ${BIN_DIR} || return

    ${APT_INSTALL} build-essential libpam0g-dev libxcb-xkb-dev > /dev/null 2>&1

    if [ -d "ly" ]; then 
        cd ly && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/nullgemm/ly && cd ly 
    fi

    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1
    sudo systemctl enable ly.service
    
    row
    echo "LY Install Is Complete "
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------

Ctags() {

    cd ${BIN_DIR} || return

    sudo apt remove --purge ctags > /dev/null 2>&1
    ${APT_INSTALL} libjansson-dev autotools-dev autoconf > /dev/null 2>&1

    if [ -d "ctags" ]; then 
        cd ctags && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/universal-ctags/ctags && cd ctags 
    fi

    ./autogen.sh > /dev/null 2>&1
    ./configure > /dev/null 2>&1
    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1

    row
    ctags --version | grep "Universal Ctags"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Nodejs() {

    ( curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash - ) > /dev/null 2>&1
    ${APT_INSTALL} nodejs > /dev/null 2>&1

    row
    node --version
    row

    ( curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - ) > /dev/null 2>&1
    ( echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list ) > /dev/null 2>&1

    sudo apt update -y -qq > /dev/null 2>&1
    ${APT_INSTALL} yarn > /dev/null 2>&1

    sudo rm -rf /etc/apt/sources.list.d/yarn.list

    row
    yarn --version
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Hugo() {

    cd ${BIN_DIR} || return

    wget -q $GIT_DOWNLOAD/gohugoio/hugo/releases/download/v0.79.1/hugo_extended_0.79.1_Linux-64bit.deb -O $BIN_DIR/hugo.deb

    sudo dpkg -i hugo.deb > /dev/null 2>&1

    row
    hugo version
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Java() {

    ${APT_INSTALL} default-jre > /dev/null 2>&1
    ${APT_INSTALL} default-jdk > /dev/null 2>&1

    row
    java -version
    row

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
    git clone -q git@github.com:hantaotaohan/logseq.git $HOME/logseq

    row
    echo "Git Clone Done!"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Fixrofiicons() {

    sudo sed -i '$a\Icon=/home/taotao/dotfiles/.extras/icons/pdf.png' /usr/share/applications/org.pwmt.zathura.desktop
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/.extras/icons/mail.png' /usr/share/applications/neomutt.desktop 
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/.extras/icons/translate.png' /usr/share/applications/copytranslator.desktop
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/.extras/icons/browser.png' /usr/share/applications/ranger.desktop
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

    cd ${BIN_DIR} || return

    ${APT_INSTALL} libgtk-3-dev > /dev/null 2>&1

    if [ -d "dragon" ]; then 
        cd dragon && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/mwh/dragon && cd dragon 
    fi

    make  > /dev/null 2>&1
    make install  > /dev/null 2>&1

    row
    dragon --version
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Fixnautilus() {
    
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

I3blocks() {

    cd ${BIN_DIR} || return

    if [ -d "i3blocks" ]; then 
        cd i3blocks && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/vivien/i3blocks && cd i3blocks 
    fi

    ./autogen.sh > /dev/null 2>&1
    ./configure > /dev/null 2>&1
    make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1

    row
    i3blocks -V
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Yarn() {

    sudo apt remove --purge yarn

    (curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - ) > /dev/null 2>&1
    (echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list) > /dev/null 2>&1
    sudo apt update -y -qq > /dev/null 2>&1
    ${APT_INSTALL} yarn

    row
    yarn -v
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Bashdb() {

    cd ${BIN_DIR} || return

    wget -q -P ${BIN_DIR} $GIT_DOWNLOAD/hantaotaohan/dotfiles/releases/download/1.0.0/bashdb.tar.gz
    tar -zxvf bashdb.tar.gz  > /dev/null 2>&1

    cd bashdb-5.0-1.1.2
    ./configure  > /dev/null 2>&1
    make  > /dev/null 2>&1
    sudo make install  > /dev/null 2>&1

    row
    echo "BASHDB Install Done!"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

I3lockfancy() {

    cd ${BIN_DIR} || return

    if [ -d "i3lock-fancy" ]; then 
        cd i3lock-fancy && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/meskarune/i3lock-fancy && cd i3lock-fancy 
    fi

    sudo make install

    row
    echo "I3lock-Fancy Install Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------

Qutebrowser() {

    ${APT_INSTALL} qutebrowser > /dev/null 2>&1

    if [ ! -d "$HOME/.local/share/qutebrowser/greasemonkey/" ]; then
        mkdir -p $HOME/.local/share/qutebrowser/greasemonkey
    fi

    cp $HOME/.config/qutebrowser/greasemonkey/* $HOME/.local/share/qutebrowser/greasemonkey/

    row
    qutebrowser -V | head -16 | grep qutebrowser
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Weixin() {

    cd ${BIN_DIR} || return

    wget -q -P ${BIN_DIR} http://archive.ubuntukylin.com/software/pool/partner/ukylin-wine_70.6.3.25_amd64.deb 
    wget -q -P ${BIN_DIR} http://archive.ubuntukylin.com/software/pool/partner/ukylin-wechat_3.0.0_amd64.deb 

    sudo apt-get install -f -y -qq ./ukylin-wine_70.6.3.25_amd64.deb > /dev/null 2>&1
    sudo apt-get install -f -y -qq ./ukylin-wechat_3.0.0_amd64.deb > /dev/null 2>&1

    row
    echo "Weixin Install Done!"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Urxvt() {

    cd ${BIN_DIR} || return

    ${APT_INSTALL} libperl-dev > /dev/null 2>&1

    wget -q -P ${BIN_DIR} http://dist.schmorp.de/rxvt-unicode/rxvt-unicode-9.26.tar.bz2  

    tar -xvf rxvt-unicode-9.26.tar.bz2 > /dev/null 2>&1

    cd rxvt-unicode-9.26

    ./configure --enable-xft --enable-font-styles --enable-iso14755 --enable-unicode3 --enable-256-color --with-x > /dev/null 2>&1

    row
    urxvt --version 2>&1 | grep rxvt-unicode
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

St() {

    cd ${BIN_DIR} || return


    if [ -d "st" ]; then 
        cd st && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/hantaotaohan/st && cd st 
    fi

    row
    echo -e "ST Install Is Complete :: Version "  $(st -v | sed -e "s/\b\(.\)/\u\1/g" )
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------

Vifm() {

    cd "$BIN_DIR" || return

    ${APT_INSTALL} vifm > /dev/null 2>&1

    pip3 install -q --timeout 1000 --retries 20 ueberzug -i https://pypi.tuna.tsinghua.edu.cn/simple

    if [ -d "vifming" ]; then 
        cd vifmimg && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/hantaotaohan/vifmimg && cd vifmimg 
    fi

    sudo make install > /dev/null 2>&1

    row
    echo "Vifm - Vifmimg Install Done !"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Popupdict() {

    cd "$BIN_DIR" || return

    ${APT_INSTALL} python3-gi python3-gi-cairo gir1.2-gtk-3.0 > /dev/null 2>&1

    if [ -d "popup-dict" ]; then 
        cd popup-dict && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/hantaotaohan/popup-dict && cd popup-dict 
    fi

    sudo pip3 install -r requirements.txt  > /dev/null 2>&1
    sudo python3 setup.py develop  > /dev/null 2>&1

    row
    echo -e "Popup-Dict Install Is Complete"
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

Anki() {

    cd "$BIN_DIR" || return

    wget -q $GIT_DOWNLOAD/hantaotaohan/dotfiles/releases/download/1.0.0/anki.tar.bz2
    tar xf anki.tar.bz2 > /dev/null 2>&1
    cd anki-2.1.49-linux
    sudo bash install.sh > /dev/null 2>&1  

    row
    echo "Anki Install Is Complete :: Version: " $(anki -v | sed -e "s/\b\(.\)/\u\1/g")
    row

}

#---------------------------------------------------------------------------------------------------------------------------------------

I3gaps() {

    cd "$BIN_DIR" || return

    if [ -d "i3-gaps" ]; then 
        cd i3-gaps && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/Airblader/i3 i3-gaps && cd i3-gaps 
    fi

    ${APT_INSTALL} meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev > /dev/null 2>&1
    ${APT_INSTALL} libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev > /dev/null 2>&1
    ${APT_INSTALL} libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev > /dev/null 2>&1
    ${APT_INSTALL} libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev > /dev/null 2>&1
    ${APT_INSTALL} libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev > /dev/null 2>&1

    rm -rf build
    mkdir build
    meson --buildtype=release . build
    ninja -C build

    sudo install -Dm755 --verbose build/i3 /usr/bin/i3
    sudo install -Dm755 --verbose build/i3bar /usr/bin/i3bar
    sudo install -Dm755 --verbose build/i3-config-wizard /usr/bin/i3-config-wizard
    sudo install -Dm755 --verbose build/i3-dump-log /usr/bin/i3-dump-log
    sudo install -Dm755 --verbose build/i3-input /usr/bin/i3-input
    sudo install -Dm755 --verbose build/i3-msg /usr/bin/i3-msg
    sudo install -Dm755 --verbose build/i3-nagbar /usr/bin/i3-nagbar
    sudo install -Dm755 --verbose i3-dmenu-desktop /usr/bin/i3-dmenu-desktop
    sudo install -Dm755 --verbose i3-migrate-config-to-v4 /usr/bin/i3-migrate-config-to-v4
    sudo install -Dm755 --verbose i3-save-tree /usr/bin/i3-save-tree
    sudo install -Dm755 --verbose i3-sensible-editor /usr/bin/i3-sensible-editor
    sudo install -Dm755 --verbose i3-sensible-pager /usr/bin/i3-sensible-pager
    sudo install -Dm755 --verbose i3-sensible-terminal /usr/bin/i3-sensible-terminal

    row
    i3 -v
    row

}

Vim () {

    cd "$BIN_DIR" || return

    if [ -d "vim" ]; then 
        cd vim && git pull > /dev/null 2>&1
    else
        $GIT_CLONE/vim/vim && cd vim 
    fi

    sudo apt remove --purge vi vim-tiny vim vim-runtime gvim vim-common vim-gui-common vim-nox > /dev/null 2>&1
    ${APT_INSTALL} libncurses5-dev python-dev python3-dev libwxgtk3.0-dev libgtk-3-dev > /dev/null 2>&1
    ${APT_INSTALL} libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev > /dev/null 2>&1

    (sudo ./configure --with-features=huge \
        --enable-multibyte \
        --enable-fontset \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --enable-python3interp \
        --enable-luainterp \
        --enable-cscope \
        --enable-gui=auto \
        --enable-perlinterp \
        --enable-fontset \
        # --with-python-config-dir=$(python2-config --configdir) \
        --with-python3-config-dir=$(python3-config --configdir) \
        --with-compiledby="TaoTao" \
        --enable-largefile \
        --with-x \
        --enable-xim \
        --enable-fontset \
        --prefix=/usr/local) > /dev/null 2>&1

    sudo make > /dev/null 2>&1
    sudo make install > /dev/null 2>&1

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

    row
    vim --version | grep -o "VIM - Vi IMproved [0-9].[0-9]"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------

main() {

    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        alttab)
            Alttab
            ;;
        arcicons)
            Arcicons
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
        bashdb)
            Bashdb
            ;;
        i3lockfancy)
            I3lockfancy
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
        popupdict)
            Popupdict
            ;;
        anki)
            Anki
            ;;   
        i3gaps)
            I3gaps
            ;;   
        vim)
            Vim
            ;;   
        -a|--all)
            Github_Hosts
            Alttab
            Arcicons
            # Picom
            # Dunst
            Offlineimap
            Navi
            # Ctags
            Rdrview
            # Fixrofiicons
            # Fix_FZF_history
            # Fixi3terminal
            # Imagemagick
            # Jupyter
            # Nodejs
            # Calibre
            Foliate
            # Hugo
            # Java
            Github_SSH
            Clone
            Dragon
            # Ly
            # Vmware_Share_Fix
            SSH_banner
            Fixnautilus
            # Vim
            # Vifm
            I3lockfancy
            Popupdict
            # Bashdb
            # Qutebrowser
            # I3blocks
            # Yarn
            # I3gaps
            # Anki
            ;;
        *)
            echo "Command not found" >&2
    esac
}

main "$@"
