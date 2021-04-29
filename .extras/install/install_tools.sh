#!/usr/bin/env bash

Dotfiles_repo=$(pwd)
Extras_dir=$(dirname "$PWD") 
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
        gtkdarkmode         Settings Gtk DarkMode
        i3gaps              Setup I3-Gaps
        picom               Setup Picom
        dunst               Setup Dunst
        offlineimap         Auto Setting Neomutt
        navi                Setup Navi
        ctags               Setup Ctags
        rdrview             Setup Rdrview
        fcitx               Settings Fcitx Themes
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
        clone               Git clone My github Respones
        ly                  Commandline Longin 
        fixvmwareshare      Fix Vmware Share Folads
                                    
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
    make -s > /dev/null 2>&1
    sudo make install > /dev/null 2>&1
    alttab -v > $Bin_dir/alttabversion 2>&1
    sudo rm -rf $Bin_dir/alttab
    row
    grep -o -E '^alttab [1-9]\d*.\d*.\d*.\d*.\d*' $Bin_dir/alttabversion
    row
    rm -rf $Bin_dir/alttabversion
}

#---------------------------------------------------------------------------------------------------------------------------------------
Arcthemes() {
    sudo apt install -y -qq arc-theme > /dev/null 2>&1
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-theme-name = Ambiance/gtk-theme-name = Arc-Dark/g' /etc/gtk-3.0/settings.ini
    fi
    row
    echo "The Arc Themes installation is complete"
    echo "Files: /etc/gtk-3.0/settings.ini . The update has been completed"
    row
}

Arcicons() {
    cd "$Bin_dir" || return 
    git clone -q $Git_clone/horst3180/arc-icon-theme --depth 1 arc-icon-theme && cd arc-icon-theme > /dev/null 2>&1
    sudo cp -r Arc /usr/share/icons/
    sudo chmod +x /usr/share/icons/Arc
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo sed -i 's/gtk-icon-theme-name = ubuntu-mono-dark/gtk-icon-theme-name = Arc/g' /etc/gtk-3.0/settings.ini
    fi
    cd $HOME
    sudo rm -rf $Bin_dir/arc-icon-theme
    row
    echo "The Arc Icons installation is complete"
    echo "Files: /etc/gtk-3.0/settings.ini . The update has been completed"
    row
}

Gtkdarkmode() {
    if [ -f /etc/gtk-3.0/settings.ini ]; then
        sudo cp $Extras_dir/gtk3setting/settings.ini /etc/gtk-3.0/settings.ini
    fi
    row
    echo "Has been setting GTK Dark Mode"
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
    unzip i3gaps.zip
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
    rm -rf i3gaps*
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
    sudo chmod +x /usr/local/bin/navi
    if [ -d "$HOME/.local/share/navi/cheats/denisidoro__cheats/" ]; then
        ln -fs $Extras_dir/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    else
        mkdir -p $HOME/.local/share/navi/cheats/denisidoro__cheats
        ln -fs $Extras_dir/cheatsheets/cheatsheets.cheat $HOME/.local/share/navi/cheats/denisidoro__cheats/cheatsheets.cheat
    fi
    row
    navi -V
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Picom() {
    sudo apt install -y -qq libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev \
    libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev \
    libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev \
    meson  > /dev/null 2>&1
    git clone -q $Git_clone/yshui/picom.git  $Bin_dir/picom
    cd $Bin_dir/picom
    git submodule update --init --recursive > /dev/null 2>&1
    meson --buildtype=release . build > /dev/null 2>&1
    sudo ninja -C build > /dev/null 2>&1
    sudo ninja -C build install > /dev/null 2>&1
    cd $HOME
    sudo rm -rf $Bin_dir/picom
    sed -i "s|# exec --no-startup-id picom --config ~/.config/picom/picom.conf|exec --no-startup-id picom --config ~/.config/picom/picom.conf|g" $HOME/.config/i3/config
    sed -i "s|exec --no-startup-id compton --config ~/.config/compton/compton.conf|# exec --no-startup-id compton --config ~/.config/compton/compton.conf|g" $HOME/.config/i3/config
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
    echo " It Is Now Being Configured Offlineimap ...... "
    echo " Please Enter The Zip Package Password "
    unzip -d $HOME/.config/neomutt/ $HOME/.config/neomutt/user.pass
    sudo cp /usr/share/doc/offlineimap/examples/systemd/offlineimap.service /etc/systemd/user
    systemctl --user enable offlineimap
    systemctl --user start offlineimap
    sudo chmod 600 $HOME/.msmtprc
    row
    echo "Neomutt Config Doen! "
    neomutt -v | grep -o -E "NeoMutt [1-9]\d*.\d*.\d*.\d*.\d*..."
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fcitx() {
    if [ -f $HOME/.config/fcitx/conf/fcitx-classic-ui.config ]; then
        sudo rm -rf $HOME/.config/fcitx/conf/fcitx-classic-ui.config
        sudo cp $Extras_dir/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    else
        mkdir -p $HOME/.config/fcitx/conf
        sudo cp $Extras_dir/fcitx/fcitx-classic-ui.config $HOME/.config/fcitx/conf/fcitx-classic-ui.config
    fi

    if [ -f $HOME/.config/fcitx/conf/fcitx-keyboard.config ]; then
        sudo rm -rf $HOME/.config/fcitx/conf/fcitx-keyboard.config
        sudo cp $Extras_dir/fcitx/fcitx-keyboard.config $HOME/.config/fcitx/conf/fcitx-keyboard.config
    else
        mkdir -p $HOME/.config/fcitx/conf
        sudo cp $Extras_dir/fcitx/fcitx-keyboard.config $HOME/.config/fcitx/conf/fcitx-keyboard.config
    fi
    
    if [ -f $HOME/.config/fcitx/config ]; then
        sudo rm -rf $HOME/.config/fcitx/config
        sudo cp $Extras_dir/fcitx/config $HOME/.config/fcitx/config
    else
        sudo cp $Extras_dir/fcitx/config $HOME/.config/fcitx/config
    fi

    if [ -f $HOME/.config/fcitx/skin/dark/fcitx_skin.conf  ]; then
        sudo rm -rf $HOME/.config/fcitx/skin/dark/fcitx_skin.conf
        sudo cp $Extras_dir/fcitx/fcitx_skin.conf $HOME/.config/fcitx/skin/dark/fcitx_skin.conf
    else
        mkdir -p $HOME/.config/fcitx/skin/dark
        sudo cp $Extras_dir/fcitx/fcitx_skin.conf $HOME/.config/fcitx/skin/dark/fcitx_skin.conf
    fi
    
    if [ -f $HOME/.config/fcitx/skin/dark/bar.png  ]; then
        sudo rm -rf $HOME/.config/fcitx/skin/dark/bar.png
        sudo cp $Extras_dir/fcitx/bar.png $HOME/.config/fcitx/skin/dark/bar.png
    else
        mkdir -p $HOME/.config/fcitx/skin/dark
        sudo cp $Extras_dir/fcitx/bar.png $HOME/.config/fcitx/skin/dark/bar.png
    fi
    row
    fcitx -v
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
    git clone git@github.com:hantaotaohan/vimwiki.git $HOME/vimwiki
    git clone git@github.com:hantaotaohan/hantaotaohan.github.io.git $HOME/blog
    git clone git@github.com:hantaotaohan/books.git $HOME/books
    row
    echo "Git Clone Done!"
    row
}

#---------------------------------------------------------------------------------------------------------------------------------------
Fixrofiicons() {
    sudo sed -i '$a\Icon="${HOME}"/debian/.extras/icons/pdf.png' /usr/share/applications/zathura.desktop
    sudo sed -i '$a\Icon="${HOME}"/debian/.extras/icons/mail.png' /usr/share/applications/neomutt.desktop 
    sudo sed -i '$a\Icon="${HOME}"/debian/.extras/icons/translate.png' /usr/share/applications/copytranslator.desktop
    sudo sed -i '$a\Icon="${HOME}"/debian/.extras/icons/browser.png' /usr/share/applications/ranger.desktop
    row
    echo "Fix Rofi Icons Done!"
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
        gtkdarkmode)
            Gtkdarkmode
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
        fcitx)
            Fcitx
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
        -a|--all)
            Github_Hosts
            Alttab
            Arcthemes
            Arcicons
            Gtkdarkmode
            I3gaps
            Picom
            Dunst
            Offlineimap
            Navi
            Ctags
            Rdrview
            Fcitx
            Fixrofiicons
            Fix_FZF_history
            #Imagemagick
            Jupyter
            Nodejs
            SSR
            Calibre
            Foliate
            Crossover
            Copytranslator
            Hugo
            Java
            Clone
            #Ly
            Vmware_Share_Fix
            Github_SSH
            SSH_banner
            ;;
        -m|--minimize)
            Github_Hosts
            Alttab
            Arcthemes
            Arcicons
            Gtkdarkmode
            I3gaps
            Picom
            Dunst
            Offlineimap
            Navi
            Ctags
            Rdrview
            Fcitx
            Fixrofiicons
            Fix_FZF_history
            #Imagemagick
            Github_SSH
            SSH_banner
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
            ;;             
        *)
            echo "Command not found" >&2
    esac
}

main "$@"
