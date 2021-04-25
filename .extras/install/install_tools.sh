#!/usr/bin/env bash

Dotfiles_repo=$(pwd)
Extras_dir=$(dirname "$PWD") 
Bin_dir="$HOME/.bin"

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
                                                                                   
     -h        Print this message                                                  
                                                                                   
     -a        Setup All                                                           
     -s        Setup Server All                                                    
                                                                                   
    -------------------------------------------------------------------------------
                                                                                   
     -1        Setup Alttab                                                        
     -2        Setup Arc-themes                                                    
     -3        Setup Arc-icons                                                     
     -4        Setup Copytranslator                                                
     -5        Setup Crossover & Kindle                                            
     -6        Setup I3gaps                                                        
     -7        Setup Imagemagick                                                   
     -8        Setup Jupyter Themes                                                
     -9        Setup Navi                                                          
     -10       Setup Peek                                                          
     -11       Setup Picom                                                         
     -12       Setup SSR Tools                                                     
     -13       Update Dunst                                                        
     -14       Update VIM with PPA                                                 
     -15       Auto Start Run Offlineimap                                          
     -16       Config Fcitx                                                        
     -17       Config GTK with Ctrl+xcv                                            
     -18       Config Github SSH                                                   
     -19       Config Github_Hosts > Hosts                                         
     -20       Config I3wm - Defaul - I3_Sensible_Terminal - Fix                   
     -21       Fix VMware Share Floader                                            
     -22       Setup Calibre                                                       
     -23       Setup Foliate                                                       
     -24       Setup Rdrview                                                       
     -25       Setup I3wm                                                          
     -26       Setup SSH_banner                                                    
     -27       Setup Ly                                                            
     -28       Setup Ctags                                                         
     -29       Setup Nodejs & Yarn                                                 
     -30       Setup Crow_Translate                                                
     -31       Setup Hugo                                                          
     -32       Setup Java                                                          
     -33       Fix FZF-history                                                     
     -34       Git Clone Mywiki and hugowiki                                       
     -35       Fix Icons                                                           
     -36       Setup Alacritty                                                     
                                                                                   
    -------------------------------------------------------------------------------
                                                                                   
     -q        Exit                                                                
                                                                                   
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
    git clone -q https://hub.fastgit.org/sagb/alttab.git $Bin_dir/alttab && cd $Bin_dir/alttab
    ./configure 
    make -s
    sudo make install 
    alttab -v > $Bin_dir/alttabversion 2>&1
    row
    grep -o -E '^alttab [1-9]\d*.\d*.\d*.\d*.\d*' $Bin_dir/alttabversion
    row
    rm -rf $Bin_dir/alttabversion
    sudo rm -rf $Bin_dir/alttab
}

#---------------------------------------------------------------------------------------------------------------------------------------
Arcthemes() {
    sudo apt install -y arc-theme
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-theme-name = Ambiance/gtk-theme-name = Arc-Dark/g' /etc/gtk-3.0/settings.ini
    fi
    row
}

Arcicons() {
    git clone https://hub.fastgit.org/horst3180/arc-icon-theme --depth 1 $Bin_dir/arc-icon-theme && cd $Bin_dir/arc-icon-theme
    sudo cp -r Arc /usr/share/icons/
    sudo chmod +x /usr/share/icons/Arc
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-icon-theme-name = ubuntu-mono-dark/gtk-icon-theme-name = Arc/g' /etc/gtk-3.0/settings.ini
    fi
    cd $HOME
    sudo rm -rf $Bin_dir/arc-icon-theme
    row
}

Gtkdarkthme() {
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo cp $Extras_dir/gtk3setting/settings.ini /etc/gtk-3.0/settings.ini
    fi
    row
}
#---------------------------------------------------------------------------------------------------------------------------------------
Copytranslator() {
    wget -P $HOME/desktop https://download.fastgit.org/CopyTranslator/CopyTranslator/releases/download/v10.0.0-beta.2/copytranslator_10.0.0-beta.2_amd64.deb
    cd $HOME/desktop
    sudo dpkg -i copytranslator_10.0.0-beta.2_amd64.deb
    sudo chown -R $USER:$USER /dev/input/mice
    cd $HOME
    sudo rm -rf $HOME/desktop/copytranslator_10.0.0-beta.2_amd64.deb
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Crossover() {
    wget -P $HOME/desktop/ https://download.fastgit.org/hantaotaohan/dotfiles/releases/download/1.0.3/crossover-20.deb
    wget -P $HOME/desktop/ https://download.fastgit.org/hantaotaohan/dotfiles/releases/download/1.0.3/winewrapper.exe.so
    wget -P $HOME/desktop/ https://download.fastgit.org/hantaotaohan/dotfiles/releases/download/1.0.3/kindle.zip
    sudo dpkg -i $HOME/desktop/crossover-20.deb
    sudo apt install -f -y
    sudo dpkg -i $HOME/desktop/crossover-20.deb
    sudo mv /opt/cxoffice/lib/wine/winewrapper.exe.so /opt/cxoffice/lib/wine/winewrapper.exe.so.bak
    sudo cp $HOME/desktop/winewrapper.exe.so /opt/cxoffice/lib/wine/
    cd $HOME
    sudo rm -rf $HOME/desktop/winewrapper.exe.so crossover-20.deb
    sudo dpkg --add-architecture i386 && \
    sudo apt-get update && \
    sudo apt-get install -y gstreamer1.0-plugins-base:i386 \
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
    sudo add-apt-repository -y ppa:kgilmer/speed-ricer
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt-get update
    sudo apt install -y i3-gaps-wm
    sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove ppa:kgilmer/speed-ricer
    sed -i 's|# smart_gaps on|smart_gaps on|g' $HOME/.config/i3/config
    sed -i 's|# gaps inner 8|gaps inner 8|g' $HOME/.config/i3/config
    sed -i 's|# gaps outer 2|gaps outer 2|g' $HOME/.config/i3/config
    sed -i 's|# smart_gaps inverse_outer|smart_gaps inverse_outer|g' $HOME/.config/i3/config
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Imagemagick() {
    sudo apt install -y imagemagick
    if [ -f /etc/ImageMagick-6/policy.xml ]; then
        sudo sed -i 's/<policy domain="coder" rights="none" pattern="PDF" \/>/<policy domain="coder" rights="read|write" pattern="PDF" \/>/g' /etc/ImageMagick-6/policy.xml
    fi
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Jupyter() {
    sudo pip3 install -q --timeout 1000 --retries 20 ipython notebook prompt-toolkit -i https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null 2>&1
    if [ ! -d "$HOME/.jupyter/custom/" ]
    then
        mkdir -p $HOME/.jupyter/custom/
        cp $Dotfiles_repo/jupyter/custom.css $HOME/.jupyter/custom/custom.css
    fi

    if [ ! -d "$HOME/.ipython/profile_default/startup/" ]
    then
        mkdir -p $HOME/.ipython/profile_default/startup/
        cp $Dotfiles_repo/jupyter/startup.py $HOME/.ipython/profile_default/startup/startup.py
    fi
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Navi() {
    sudo bash -c "$(wget -O- https://raw.fastgit.org/denisidoro/navi/master/scripts/install)"
    if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        ln -fs $Dotfiles_repo/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    else
        mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
        ln -fs $Dotfiles_repo/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    fi
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Peek() {
    sudo add-apt-repository -y ppa:peek-developers/stable
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt update
    sudo apt install -y peek
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove peek-developers/stable
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Picom() {
    sudo apt install -y libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev libx11-xcb-dev
    sudo apt install -y meson
    git clone https://hub.fastgit.org/yshui/picom.git $HOME/desktop/picom && \
    cd $HOME/desktop/picom && \
    git submodule update --init --recursive && \
    meson --buildtype=release . build && \
    sudo ninja -C build && \
    sudo ninja -C build install && \
    cd $HOME
    sudo rm -rf $HOME/desktop/picom
    sed -i "s|# exec --no-startup-id picom --config ~/.config/picom/picom.conf|exec --no-startup-id picom --config ~/.config/picom/picom.conf|g" $HOME/.config/i3/config
    sed -i "s|exec --no-startup-id compton --config ~/.config/compton/compton.conf|# exec --no-startup-id compton --config ~/.config/compton/compton.conf|g" $HOME/.config/i3/config
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
SSR() {
    wget -P $HOME/desktop https://download.fastgit.org/shadowsocksrr/electron-ssr/releases/download/0.3.0-alpha.6/electron-ssr-0.3.0-alpha.6.deb
    sudo dpkg -i $HOME/desktop/electron-ssr-0.3.0-alpha.6.deb
    sudo apt install -f -y
    sudo dpkg -i $HOME/desktop/electron-ssr-0.3.0-alpha.6.deb
    cd $HOME
    sudo rm -rf $HOME/desktop/electron-ssr-0.3.0-alpha.6.deb
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Dunst() {
    sudo apt install -y libdbus-1-dev libx11-dev libxinerama-dev libxrandr-dev libxss-dev libglib2.0-dev libpango1.0-dev libgtk-3-dev libxdg-basedir-dev libnotify-dev
    git clone https://hub.fastgit.org/dunst-project/dunst.git $HOME/desktop/dunst
    cd $HOME/desktop/dunst
    make
    sudo make install
    cd $HOME
    rm -rf $HOME/desktop/dunst
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
VIM() {
    sudo apt-get remove --purge vi vim-tiny vim vim-runtime gvim vim-common vim-gui-common vim-nox
    sudo add-apt-repository -y ppa:jonathonf/vim
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt update
    sudo apt install -y vim vim-gtk
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove ppa:jonathonf/vim
    row
    vim --version | grep "VIM - Vi IMproved "
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Offlineimap() {
    echo " Config and Unzip passwords "
    unzip -d $HOME/.config/neomutt/ $HOME/.config/neomutt/user.pass
    sudo cp /usr/share/doc/offlineimap/examples/systemd/offlineimap.service /etc/systemd/user
    systemctl --user enable offlineimap
    systemctl --user start offlineimap
    sudo chmod 600 $HOME/.msmtprc
    row
    echo " Neomutt Config Doen! "
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fcitx() {
    if [ -f $HOME/.config/fcitx/conf/fcitx-classic-ui.config ]; then
        sudo rm -rf $HOME/.config/fcitx/conf/fcitx-classic-ui.config
        sudo cp $Dotfiles_repo/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    else
        mkdir -p $HOME/.config/fcitx/conf
        sudo cp $Dotfiles_repo/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    fi

    if [ -f $HOME/.config/fcitx/conf/fcitx-keyboard.config ]; then
        sudo rm -rf $HOME/.config/fcitx/conf/fcitx-keyboard.config
        sudo cp $Dotfiles_repo/fcitx/fcitx-keyboard.config $HOME/.config/fcitx/conf/fcitx-keyboard.config
    else
        mkdir -p $HOME/.config/fcitx/conf
        sudo cp $Dotfiles_repo/fcitx/fcitx-keyboard.config $HOME/.config/fcitx/conf/fcitx-keyboard.config
    fi
    
    if [ -f $HOME/.config/fcitx/config ]; then
        sudo rm -rf $HOME/.config/fcitx/config
        sudo cp $Dotfiles_repo/fcitx/config $HOME/.config/fcitx/config
    else
        sudo cp $Dotfiles_repo/fcitx/config $HOME/.config/fcitx/config
    fi

    if [ -f $HOME/.config/fcitx/skin/dark/fcitx_skin.conf  ]; then
        sudo rm -rf $HOME/.config/fcitx/skin/dark/fcitx_skin.conf
        sudo cp $Dotfiles_repo/fcitx/fcitx_skin.conf $HOME/.config/fcitx/skin/dark/fcitx_skin.conf
    else
        mkdir -p $HOME/.config/fcitx/skin/dark
        sudo cp $Dotfiles_repo/fcitx/fcitx_skin.conf $HOME/.config/fcitx/skin/dark/fcitx_skin.conf
    fi
    
    if [ -f $HOME/.config/fcitx/skin/dark/bar.png  ]; then
        sudo rm -rf $HOME/.config/fcitx/skin/dark/bar.png
        sudo cp $Dotfiles_repo/fcitx/bar.png $HOME/.config/fcitx/skin/dark/bar.png
    else
        mkdir -p $HOME/.config/fcitx/skin/dark
        sudo cp $Dotfiles_repo/fcitx/bar.png $HOME/.config/fcitx/skin/dark/bar.png
    fi
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Github_SSH() {
    if ! [ -f $HOME/.ssh/id_rsa.pub ]; then
        echo 'Email for ssh key'
        read -e ssh_email
        ssh-keygen -t rsa -P "" -C "$ssh_email"  -f ~/.ssh/id_rsa
        echo 'Key copied to keyboard'
        xclip -sel clip < $HOME/.ssh/id_rsa.pub
        google-chrome --new-window 'https://github.com/settings/keys'
    fi
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Github_Hosts() {
    sudo sed -i '/# GitHub/,$d' /etc/hosts
    sudo sed -i '$a\# ------------------------------------------------------------------' /etc/hosts
    sudo python3 $Dotfiles_repo/github_hosts.py
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
I3_Sensible_Terminal() {
    if [ -f /usr/bin/i3-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/rofi-sensible-terminal
    fi
    if [ -f /usr/bin/rofi-sensible-terminal ]; then
        sudo sed -i 's/konsole/konsole alacritty/g' /usr/bin/i3-sensible-terminal
    fi
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
    sudo apt install calibre
    git clone https://github.com/hantaotaohan/books $HOME/books
}

#---------------------------------------------------------------------------------------------------------------------------------------
Foliate() {
    sudo snap install foliate
}

#---------------------------------------------------------------------------------------------------------------------------------------
Rdrview() {
    sudo apt install libxml2-dev libseccomp-dev libcurl4-gnutls-dev
    git clone https://hub.fastgit.org/eafer/rdrview.git $HOME/desktop/rdrview
    cd $HOME/desktop/rdrview
    make
    sudo make install
    cd $HOME
    rm -rf $HOME/desktop/rdrview
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
I3wm() {
    sudo add-apt-repository -y ppa:kgilmer/speed-ricer
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt-get update
    sudo apt install -y i3 i3-wm
    sudo apt-get -y -qq --purge remove rxvt-unicode > /dev/null 2>&1 
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove ppa:kgilmer/speed-ricer
    row
    i3 --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
SSH_banner() {
    sudo sed -i '$a\Banner \/etc\/ssh\/my_ssh_banner' /etc/ssh/sshd_config
    sudo cp $Dotfiles_repo/banner/my_ssh_banner /etc/ssh/
    systemctl restart sshd
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Ly() {
    sudo apt install -y build-essential libpam0g-dev libxcb-xkb-dev
    git clone https://github.com/nullgemm/ly.git $HOME/desktop/ly
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
    sudo apt purge --remove ctags
    sudo apt-get install -y libjansson-dev autotools-dev autoconf
    git clone https://hub.fastgit.org/universal-ctags/ctags.git --depth=1 $HOME/desktop/ctags
    cd $HOME/desktop/ctags
    ./autogen.sh
    ./configure
    make
    sudo make install
    cd $HOME
    rm -rf $HOME/desktop/ctags
    row
    ctags --version | grep "Universal Ctags"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Nodejs() {
    curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
    sudo apt install -y nodejs
    row
    node --version
    row
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update
    sudo apt install -y yarn
    sudo rm -rf /etc/apt/sources.list.d/yarn.list
    row
    yarn --version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Crow_Translate() {
    wget --tries=40 -P $HOME/desktop https://download.fastgit.org/crow-translate/crow-translate/releases/download/2.6.1/crow-translate_2.6.1_amd64.deb
    cd $HOME/desktop
    sudo dpkg -i crow-translate_2.6.1_amd64.deb
    sudo apt install -f
    sudo dpkg -i crow-translate_2.6.1_amd64.deb   
    rm -rf $HOME/desktop/crow-translate_2.6.1_amd64.deb
    cd $HOME
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Hugo() {
    wget https://download.fastgit.org/gohugoio/hugo/releases/download/v0.79.1/hugo_extended_0.79.1_Linux-64bit.deb -O $HOME/desktop/hugo.deb
    cd $HOME/desktop
    sudo dpkg -i hugo.deb
    cd $HOME
    rm -rf $HOME/desktop/hugo.deb
    row
    hugo version
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Java() {
    sudo apt install -y default-jre
    sudo apt install -y default-jdk
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
    git clone git@github.com:hantaotaohan/vimwiki.git $HOME/vimwiki
    git clone git@github.com:hantaotaohan/hantaotaohan.github.io.git $HOME/blog
    git clone git@github.com:hantaotaohan/books.git $HOME/books
    row
    echo "Git Clone Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fixrofiicons() {
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/setup/icons/pdf.png' /usr/share/applications/zathura.desktop
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/setup/icons/mail.png' /usr/share/applications/neomutt.desktop 
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/setup/icons/translate.png' /usr/share/applications/copytranslator.desktop
    sudo sed -i '$a\Icon=/home/taotao/dotfiles/setup/icons/browser.png' /usr/share/applications/ranger.desktop
}

#---------------------------------------------------------------------------------------------------------------------------------------
Alacritty() {
    sudo add-apt-repository -y ppa:aslatter/ppa
    sudo sed -i "s/http:\/\/ppa.launchpad.net/https:\/\/launchpad.proxy.ustclug.org/g" /etc/apt/sources.list.d/*.list
    sudo apt update
    sudo apt install -y alacritty
    sudo sed -i "s/https:\/\/launchpad.proxy.ustclug.org/http:\/\/ppa.launchpad.net/g" /etc/apt/sources.list.d/*.list
    sudo add-apt-repository -y --remove peek-developers/stable
    row
}

main() {



    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -1)
            Alttab
            ;;
        -2)
            Arcthemes
            ;;
        -3)
            Arcicons
            ;;
        -4)
            Copytranslator
            ;;
        -5)
            Crossover
            ;;
        -6)
            I3gaps
            ;;
        -7)
            Imagemagick
            ;;
        -8)
            Jupyter
            ;;
        -9)
            Navi
            ;;
        -10)
            Peek
            ;;
        -11)
            Picom
            ;;
        -12)
            SSR
            ;;
        -13)
            Dunst
            ;;
        -14)
            VIM
            ;;
        -15)
            Offlineimap
            ;;
        -16)
            Fcitx
            ;;
        -17)
            GTK
            ;;
        -18)
            Github
            ;;
        -19)
            Github_Hosts
            ;;
        -20)
            I3_Sensible_Terminal
            ;;
        -21)
            Vmware_Share_Fix
            ;;
        -22)
            Calibre
            ;;
        -23)
            Foliate
            ;;
        -24)
            Rdrview
            ;;
        -25)
            I3wm
            ;;
        -26)
            SSH_banner
            ;;
        -27)
            Ly
            ;;
        -28)
            Ctags
            ;;
        -29)
            Nodejs
            ;;
        -30)
            Crow_Translate
            ;;
        -31)
            Hugo
            ;; 
        -32)
            Java
            ;;
        -33)
            Fix_FZF_history
            ;;
        -34)
            Clone
            ;;  
        -35)
            Fixicons
            ;;  
        -36)
            Alacritty
            ;;  
        -[aA])
            Github_Hosts
            Alttab
            Arcthemes
            Arcicons
            Copytranslator
            #Crossover
            Imagemagick
            Jupyter
            Navi
            #Peek
            #SSR
            Dunst
            VIM
            Offlineimap
            Fcitx
            GTK
            #Github
            #Vmware_Share_Fix
            #Calibre
            #Foliate
            Rdrview
            I3wm
            I3gaps
            I3_Sensible_Terminal
            Picom
            SSH_banner
            #Ly
            Ctags
            Nodejs
            #Crow_Translate
            Hugo
            Java
            Fix_FZF_history
            Fixicons
            sudo rm -rf /etc/apt/sources.list.d/*
            ;;
        -[sS])
            VIM
            Imagemagick
            Jupyter
            Navi
            Offlineimap
            Rdrview
            SSH_banner
            Ctags
            Nodejs
            Github
            Github_Hosts
            Hugo
            Java
            Fix_FZF_history
            ;; 
        -[qQ]) 
            exit; break 
            ;;
        *)
            echo "Command not found" >&2
            # exit 1
    esac
}

while true ; do
main "$@"
done
