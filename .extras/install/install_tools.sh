#!/usr/bin/env bash

Dotfiles_repo=$(pwd)
Extras_dir=$(dirname "$PWD") 
Bin_dir="$HOME/.bin"
Quiet="> /dev/null 2>&1"

#Git_clone="https://hub.fastgit.org"
#Git_download="https://download.fastgit.org"

#Git_clone="https://github.com"
#Git_download="https://github.com"

Git_clone="git clone -q https://github.com.cnpmjs.org"
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
        alttab              Install Program Alttab - Same Windows Alt Tab
        anki                Install Program Anki
        arcicons            Install Gtk Dark-themes Icons
        arcthemes           Install Gtk Dark-themes
        bashdb              Install Program Bashdb Bash Debug Tools
        ctags               Install Program  News Version Universal-Ctags 
        clone               Git Clone Need SSH-KEY Is My Github Respones
        calibre             Install Program Calibre And Settings Config
        crossover           Install Program Crossover And Config Kindle
        copytranslator      Install Program Copytranslator - Translate Tools
        dunst               Install Program Dunst - X11 Message Tools
        dragon              Install Ranger Plug Dragon - Ranger Drop Function
        fixfzf              Fix Fzf Of Ctrl+r History Enter Direct Execution
        foliate             Install Program Foliate - eBook Reader
        fsearch             Install Program Fsearch - Same Windows Everthing
        fzfopen             Install Program FZF-Open - Rofi Uses Fzf Search
        fixnautilus         Fix Nautilus Views Mode
        fixrofiicons        Fix Rofi Icons - Add Other Icons
        fixi3terminal       Fix I3wm Terminal Alacritty Suppose
        fixvmwareshare      Settings Vmware Share Folads
        githubhosts         Settings Config /etc/hosts/ Uses Fast View Github.com
        githubssh           Settings Github.com SSH Key - Auto SSH_Ras Copy
        hugo                Install Program Hugo
        i3gaps              Install Program I3-Gaps
        i3lock              Install Program i3lock_fancy
        i3blocks            Install Program I3blocks
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
        ssr                 Install Program SSR - VPN Gtk
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
# Public Functions . 
#---------------------------------------------------------------------------------------------------------------------------------------

row() {
    seq -s '─' 0 "$(tput cols)" | tr -d '[:digit:]'
}

#---------------------------------------------------------------------------------------------------------------------------------------
# Install Tools
#---------------------------------------------------------------------------------------------------------------------------------------

Alttab() {
    eval sudo apt install -qq -y libx11-dev libxmu-dev libxft-dev libxrender-dev libxrandr-dev libpng-dev uthash-dev libxpm-dev libxpm4 $Quiet
    eval cd $Bin_dir 
    if [ -d "alttab" ]; then 
        eval cd alttab && eval git pull $Quiet
    else
        $Git_clone/sagb/alttab && eval cd alttab 
        ./configure $Quiet && make $Quiet && sudo make install $Quiet
    fi
    row
    echo -e "Alttab Install Is Complete :: Version "  $(alttab -v 2>&1 | grep -i 'alttab' | head -n 1 | sed -e "s/\b\(.\)/\u\1/g" )
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Arcthemes() {
    eval sudo apt install -y -qq arc-theme $Quiet
    row
    echo "The Arc Themes installation is complete"
    row
}

Arcicons() {
    cd $Bin_dir 
    if [ -d "arc-icon-theme" ]; then 
        eval cd arc-icon-theme && eval git pull $Quiet
    else
        $Git_clone/horst3180/arc-icon-theme && cd arc-icon-theme 
        if ! [ -d "$HOME/.local/share/icons/" ]; then
            eval mkdir -p $HOME/.local/share/icons/
            eval cp -rf Arc/ $HOME/.local/share/icons/
        else
            eval cp -rf Arc/ $HOME/.local/share/icons/
        fi
    fi
    row
    echo "The Arc Icons installation is complete"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Copytranslator() {
    eval cd $Bin_dir
    eval wget -q $Git_download/CopyTranslator/CopyTranslator/releases/download/v10.0.0-beta.2/copytranslator_10.0.0-beta.2_amd64.deb
    eval sudo dpkg -i copytranslator_10.0.0-beta.2_amd64.deb $Quiet
    row
    echo "Copytranslator Install Completed :: Version 10.0.0 - beta2"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Crossover() {
    eval cd $Bin_dir
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/crossover-20.deb && \
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/winewrapper.exe.so && \
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/kindle.zip && \
    eval sudo dpkg -i crossover-20.deb $Quiet
    eval sudo apt install -f -y -qq $Quiet
    eval sudo dpkg -i crossover-20.deb $Quiet
    sudo mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
    sudo cp winewrapper.exe.so /opt/cxoffice/lib/wine/
    sudo dpkg --add-architecture i386
    sudo apt-get update -y -qq
    row
    echo "Crossover Install Completed :: Version 21.1.0"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
# I3gaps() {
#     cd "$Bin_dir" || return 
#     wget -q -P $Bin_dir $Git_download/hantaotaohan/debian/releases/download/1.0.0/i3gaps.zip
#     unzip -q i3gaps.zip
#     sudo dpkg -i i3gpas1.deb > /dev/null 2>&1
#     sudo dpkg -i i3gpas2.deb > /dev/null 2>&1
#     sudo dpkg -i i3gpas3.deb > /dev/null 2>&1
#     sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
#     sed -i 's|# smart_gaps on|smart_gaps on|g' $HOME/.config/i3/config
#     sed -i 's|# gaps inner 8|gaps inner 8|g' $HOME/.config/i3/config
#     sed -i 's|# gaps outer 2|gaps outer 2|g' $HOME/.config/i3/config
#     sed -i 's|# smart_gaps inverse_outer|smart_gaps inverse_outer|g' $HOME/.config/i3/config
#     row
#     echo "I3 - Gaps Install Completed"
#     row
#     rm -rf i3gaps* i3gpas*
# }

#---------------------------------------------------------------------------------------------------------------------------------------
Imagemagick() {
    eval sudo apt install -y -qq imagemagick $Quiet
    if [ -f /etc/ImageMagick-6/policy.xml ]; then
        sudo sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
    fi
    row
    echo "Imagemagick Fix Completed"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Jupyter() {
    eval sudo pip3 install -q --timeout 1000 --retries 20 ipython notebook prompt-toolkit -i https://pypi.tuna.tsinghua.edu.cn/simple $Quiet
    if [ ! -d "$HOME/.jupyter/custom/" ]; then
        eval mkdir -p $HOME/.jupyter/custom/
        eval cp $Extras_dir/jupyter/custom.css $HOME/.jupyter/custom/custom.css
    fi

    if [ ! -d "$HOME/.ipython/profile_default/startup/" ]; then
        eval mkdir -p $HOME/.ipython/profile_default/startup/
        eval cp $Extras_dir/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py
    fi
    row
    echo -e "Jupyter Install Is Complete :: Version "  $( jupyter --version | grep -iE "ipython|notebook" | sed -e "s/\b\(.\)/\u\1/g" )
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Navi() {
    eval cd $Bin_dir
    eval wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/navi
    sudo mv $Bin_dir/navi /usr/local/bin
    if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        eval ln -fs $Extras_dir/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    else
        eval mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
        eval ln -fs $Extras_dir/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    fi
    sudo chmod +x /usr/local/bin/navi
    row
    echo -e "Navi Install Is Complete :: Version "  $( navi -V | sed -e "s/\b\(.\)/\u\1/g" )
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Picom() {
    eval sudo apt install -y -qq libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev meson $Quiet
    eval sudo apt install -y -qq libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev $Quiet
    eval sudo apt install -y -qq libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev $Quiet
    eval cd $Bin_dir 
    if [ -d "picom" ]; then 
        eval cd picom && eval git pull $Quiet
    else
        $Git_clone/yshui/picom && eval cd picom 
        rm -rf build
        git submodule update --init $Quiet
        meson --buildtype=release . build -Dwith_docs=false $Quiet
        ninja -C build $Quiet
        sudo install -Dm755 --verbose build/src/picom /usr/local/bin/picom $Quiet
    fi
    row
    echo "Picom Install Is Complete :: Version: " $(picom --version | sed -e "s/\b\(.\)/\u\1/g")
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
SSR() {
    eval cd $Bin_dir 
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/electron-ssr.deb
    eval sudo dpkg -i electron-ssr.deb $Quiet
    eval sudo apt install -f -y $Quiet
    eval sudo dpkg -i electron-ssr.deb $Quiet
    row
    echo "Picom Install Is Complete :: Version: " $(picom --version | sed -e "s/\b\(.\)/\u\1/g")
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Dunst() {
    eval cd $Bin_dir 
    eval sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev $Quiet
    if [ -d "dunst" ]; then 
        eval cd dunst && eval git pull $Quiet
    else
        $Git_clone/dunst-project/dunst && eval cd dunst 
        make $Quiet && sudo make install $Quiet
    fi
    row
    echo "Dunst Install Is Complete :: Version: " $(dunst -v | sed -e "s/\b\(.\)/\u\1/g")
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Offlineimap() {
    row
    echo "Please enter the password to extract the package  "
    row
    unzip -o -q -d $HOME/.config/neomutt/ $HOME/.config/neomutt/user.pass
    row
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
    echo "Neomutt Install Is Complete :: Version: " $(neomutt -v | grep -o -E "NeoMutt [1-9]\d*.\d*.\d*.\d*.\d*...")
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Github_SSH() {
    if ! [ -f $HOME/.ssh/id_rsa.pub ]; then
        row
        echo "Please Input Email Addrsses For SSH Key"
        row
        read -e ssh_email
        eval ssh-keygen -t rsa -P "" -C "$ssh_email"  -f ~/.ssh/id_rsa $Quiet
        echo 'Key copied to keyboard'
        row
        xclip -sel clip < $HOME/.ssh/id_rsa.pub
        eval microsoft-edge --new-window 'https://github.com/settings/keys' $Quiet
    else
        echo 'Key copied to keyboard'
        row
        xclip -sel clip < $HOME/.ssh/id_rsa.pub
        eval microsoft-edge --new-window 'https://github.com/settings/keys' $Quiet
    fi
    echo "Add Github For SSH Key Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Github_Hosts() {
    sudo python3 $Extras_dir/autohosts/github_hosts.py
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
    eval cd $Bin_dir 
    eval sudo apt install -y -qq calibre $Quiet
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/calibre.zip
    unzip -o -q -d $HOME/.config/ $Bin_dir/calibre.zip
    $Git_clone/hantaotaohan/books $HOME/books
    row
    echo "Calibre Install Is Complete  & Git Clone Book Done :: Version: " $(calibre --version | sed -e "s/\b\(.\)/\u\1/g")
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Foliate() {
    eval cd $Bin_dir 
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/foliate.deb
    eval sudo dpkg -i foliate.deb $Quiet
    row
    echo "Foliate Install Is Complete :: Version: " $(com.github.johnfactotum.Foliate -v)
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Rdrview() {
    eval cd $Bin_dir 
    eval sudo apt install -y -qq libxml2-dev libseccomp-dev libcurl4-gnutls-dev $Quiet
    if [ -d "rdrview" ]; then 
        eval cd rdrview && eval git pull $Quiet
    else
        $Git_clone/eafer/rdrview && eval cd rdrview 
         make $Quiet && sudo make install $Quiet
    fi
    row
    echo -e "Rerview Install Is Complete :: Version "  $(rdrview -v | sed -e "s/\b\(.\)/\u\1/g" )
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
SSH_banner() {
    sudo sed -i '$a\Banner \/etc\/ssh\/my_ssh_banner' /etc/ssh/sshd_config
    sudo cp $Extras_dir/banner/my_ssh_banner /etc/ssh/
    # systemctl restart sshd
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
    eval cd $Bin_dir 
    if [ -d "st" ]; then 
        eval cd st && eval git pull $Quiet
    else
        $Git_clone/hantaotaohan/st && eval cd st
        eval sudo make clean install $Quiet
    fi
    row
    echo -e "ST Install Is Complete :: Version "  $(st -v | sed -e "s/\b\(.\)/\u\1/g" )
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

Popupdict() {
    eval cd $Bin_dir 
    if [ -d "popup-dict" ]; then 
        eval cd popup-dict && eval git pull $Quiet
    else
        $Git_clone/hantaotaohan/popup-dict && eval cd popup-dict 
        eval sudo pip3 install -r requirements.txt $Quiet
        eval sudo python3 setup.py develop $Quiet
    fi
    row
    echo -e "Popup-Dict Install Is Complete"
    row
}

Anki() {
    eval cd $Bin_dir 
    wget -q $Git_download/hantaotaohan/debian/releases/download/1.0.0/anki.tar.bz2
    eval tar xf anki.tar.bz2
    eval cd anki-2.1.49-linux
    eval sudo bash install.sh $Quiet
    row
    echo "Anki Install Is Complete :: Version: " $(anki -v | sed -e "s/\b\(.\)/\u\1/g")
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
        popupdict)
            Popupdict
            ;;
        anki)
            Anki
            ;;   
        -a|--all)
            Github_Hosts
            Alttab
            Arcthemes
            Arcicons
            # I3gaps
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
            # SSR
            # Calibre
            Foliate
            # Crossover
            # Copytranslator
            # Hugo
            # Java
            Github_SSH
            Clone
            Dragon
            #Ly
            #Vmware_Share_Fix
            SSH_banner
            Fixnautilus
            Fzfopen
            #Vim
            I3lock
            Popupdict
            #Bashdb
            #Qutebrowser
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
