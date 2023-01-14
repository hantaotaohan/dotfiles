#!/usr/bin/env bash

# ================================================================================================================================
#                                                                                                                                 
#                                                       Install -- Xserver                                                          
#
#                                                       Update: 2023.01.13                                                      
#                                                                                                                                 
# ================================================================================================================================

# ================================================================================================================================
#                                                       GENERAL - Settings
# ================================================================================================================================

clear

# --------------------------------------------------------------o----------------------------------------------------------------o
# Setting Bash Colors Variable 
# --------------------------------------------------------------o----------------------------------------------------------------o

RESET=$(tput sgr0)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
CYAN=$(tput setaf 6)
GREEN=$(tput setaf 2)
WHITE=$(tput setaf 7)
BLACK=$(tput setaf 0)
YELLOW=$(tput setaf 3)
MAGENTA=$(tput setaf 5)

# --------------------------------------------------------------o----------------------------------------------------------------o
# Setting Bash Ansi Center Line 
# --------------------------------------------------------------o----------------------------------------------------------------o

ROWLIN() {
    seq -s '─' 0 "$(tput cols)" | tr -d '[:digit:]'
}

STRIP_ANSI() {
    declare tmp esc tpa re
    tmp="${1}"
    esc=$(printf "\x1b")
    tpa=$(printf "\x28")
    re="(.*)${esc}[\[${tpa}][0-9]*;*[mKB](.*)"
    while [[ "${tmp}" =~ $re ]]; do
        tmp="${BASH_REMATCH[1]}${BASH_REMATCH[2]}"
    done
    printf "%s" "${tmp}"
}

CENTER() {
    [[ $# = 0 ]] && printf "%s: Missing arguments\n" "${FUNCNAME[0]}" && return 1
    declare input="${1}" symbol="${2:- }" filler out no_ansi_out
    no_ansi_out=$(STRIP_ANSI "$input")
    declare -i str_len=${#no_ansi_out}
    declare -i filler_len="$(((COLUMNS - str_len) / 2))"

    [[ -n "${symbol}" ]] && symbol="${symbol:0:1}"
    for ((i = 0; i < filler_len; i++)); do
        filler+="${symbol}"
    done

    out="${filler}${input}${filler}"
    [[ $(((COLUMNS - str_len) % 2)) -ne 0 ]] && out+="${symbol}"
    printf "%s" "${out}"
}

# ================================================================================================================================
#                                                             START
# ================================================================================================================================

ROWLIN
CENTER "                                                      ";
CENTER "██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ";
CENTER "██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ";
CENTER "██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     ";
CENTER "██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ";
CENTER "██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗";
CENTER "╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝";
CENTER "                                                      ";
ROWLIN
CENTER " ${YELLOW}TaoTao - Debian - Desktop - Install${RESET} ";
ROWLIN
CENTER "                                                      ";
CENTER "                                                      ";
CENTER "                                                      ";


# --------------------------------------------------------------o----------------------------------------------------------------o
# Setting Base Variable               
# --------------------------------------------------------------o----------------------------------------------------------------o

BACKUP_DIR="$HOME/.dotfiles.orig"
SOURCE_DIR="$HOME/.local/src"
DOTFILES_REPO=$(pwd)

GITHUB="github.com"
GITHUBRAW="https://gitee.com/hantaotaohan/dotfiles/releases/download/1"
# GITHUBRAW="https://github.com/hantaotaohan/dotfiles/releases/download/1.0.0"

DOTFILES_COPY=( \
    .bin \
    .cargo \
    .config \
    .ctags.d \
    .extras \
    .pip \
    .vim \
    .w3m \
    .Xmodmap \
    .Xresources
    .aliases \
    .bash_profile \
    .bash_prompt \
    .bashrc \
    .curlrc \
    .dircolors \
    .exports \
    .fonts.conf \
    .functions \
    .gemrc \
    .gitconfig \
    .gitignore \
    .gtkrc-2.0 \
    .imwheelrc \
    .inputrc \
    .msmtprc \
    .npmrc \
    .offlineimaprc \
    .ripgreprc \
    .tmux.conf \
    .vimrc \
    .wgetrc \
    .xinitrc \
    .xinputrc
)

# --------------------------------------------------------------o----------------------------------------------------------------o
# Setting Print Usage Message
# --------------------------------------------------------------o----------------------------------------------------------------o

usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF

Usage: $program_name [-option]

Options:

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
                                                                              
   -h        Print This Message                                               
                                                                              
   -a        Install All                                                                     
                                                                              
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
                                                                              
   -d        Install Dotfiles                                                 
   -D        Uninstall Dotfiles                                               
   -w        Install Workspace                                              
   -h        Install Hosts                                              
   -a        Install APT Tools                                                
   -p        Install PIP3 Tools                                               
   -b        Install DEB Tools                                                
   -f        Install Fonts      
   -r        Remove Apps   
                                                                        
   -q        Exit                                                             
                                                                              
──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
                                                                            
EOF

}

# ================================================================================================================================
#                                                       DOTFILES - INSTALL
# ================================================================================================================================

Install_Dotfiles() {
 
    ROWLIN
    CENTER "                                                             ";
    CENTER "██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗";
    CENTER "██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝";
    CENTER "██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗";
    CENTER "██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║";
    CENTER "██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║";
    CENTER "╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝";
    CENTER "                                                             ";
    ROWLIN
    CENTER "       ${BLUE}Start Backup and Install Dotfiles${RESET}      ";
    ROWLIN
    CENTER "                                                             ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Backup Config.

    if ! [ -f "$BACKUP_DIR/check-backup.txt" ]; then
        env mkdir -p "$BACKUP_DIR/.config"
        cd "$BACKUP_DIR" || exit
        touch check-backup.txt

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Backup Some Folder In ~/.config To ~/.dotfiles.orig/.config

        for dots_copy in "${DOTFILES_COPY[@]//./}"
        do
            env cp -rf "$HOME/${dots_copy}" "$BACKUP_DIR/.config" &> /dev/null
        done

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Backup Again With Git.

        if [ -x "$(command -v git)" ]; then
            git init &> /dev/null
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Backup original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Output.

        echo -e "\t\t${BLUE}Your config is backed up in ${BACKUP_DIR}\n" >&2
        echo -e "\t\t${RED}Please do not delete check-backup.txt in .dotfiles.orig folder.${WHITE}" >&2
        echo -e "\t\tIt's used to backup and restore your old config.\n" >&2
    fi

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Install Move(CP) .config/ To $HOME/.config

    for dots_copy in "${DOTFILES_COPY[@]}"
    do
        sudo rm -rf "$HOME/${dots_copy}"
        cp -rf "$DOTFILES_REPO/${dots_copy}" "$HOME/"
    done

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Install Sources.list | .source To etc/apt/sources.list

    sudo ln -sf "$DOTFILES_REPO/sources.list" "/etc/apt/sources.list"
    echo -e "\n\t\t${GREEN}[+]Repace sources.list Done !${RESET}\n"

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Output.

    echo -e "\t\t${BLUE}New dotfiles is installed!\n${WHITE}" >&2
    echo -e "\t\tThere may be some errors when Terminal is restarted." >&2
    echo -e "\t\tPlease read carefully the error messages and make sure." >&2
    echo -e "\t\tall packages are installed. See more info in README.md." >&2
    echo -e "\t\tNote that the author of this dotfiles uses dev branch in some packages." >&2
    echo -e "\t\tIf you want to restore your old config, " >&2
    echo -e "\t\tyou can use ${RED}./install.sh -r${WHITE} command.\n" >&2
}

# ================================================================================================================================
#                                                      DOTFILES - UNINSTALL
# ================================================================================================================================

Uninstall_Dotfiles() {

    ROWLIN
    CENTER "                                                                                   ";
    CENTER "██████╗ ███████╗      ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗";
    CENTER "██╔══██╗██╔════╝      ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝";
    CENTER "██████╔╝█████╗  █████╗██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗";
    CENTER "██╔══██╗██╔══╝  ╚════╝██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║";
    CENTER "██║  ██║███████╗      ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║";
    CENTER "╚═╝  ╚═╝╚══════╝      ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝";
    CENTER "                                                                                   ";
    ROWLIN
    CENTER "                 ${BLUE}Restore Dotfile Initial State${RESET}                      ";
    ROWLIN
    CENTER "                                                                                   ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    if [ -f "$BACKUP_DIR/check-backup.txt" ]; then
        for dots_copy in "${DOTFILES_COPY[@]}"
        do
            env rm -rf "$HOME/${dots_copy}"
            env cp -rf "$BACKUP_DIR/${dots_copy}" "$HOME/" &> /dev/null
            env rm -rf "$BACKUP_DIR/${dots_copy}"
        done

# --------------------------------------------------------------o----------------------------------------------------------------o

        # >>> Save Old Config In Backup Directory With Git.

        if [ -x "$(command -v git)" ]; then
            cd "$BACKUP_DIR" || exit
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Restore original on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi
    fi

    if ! [ -f "$BACKUP_DIR/check-backup.txt" ]; then
        echo -e "\t\t${RED}You have not installed this dotfiles yet.${WHITE}" >&2
        exit 1
    else
        echo -e "\t\t${BLUE}Your old config has been restoRED!\n${WHITE}" >&2
        echo -e "\t\tThanks for using my dotfiles." >&2
        echo -e "\t\tEnjoy your next journey!" >&2
    fi

    env rm -rf "$BACKUP_DIR/check-backup.txt"

}

# ================================================================================================================================
#                                                      WORKSPACE - SETTINGS
# ================================================================================================================================

Workspace_Settings() {

    ROWLIN
    CENTER "                                                                                               ";
    CENTER "███████╗███╗   ██╗██╗   ██╗██╗██████╗  ██████╗ ███╗   ██╗███╗   ███╗███████╗███╗   ██╗████████╗"; 
    CENTER "██╔════╝████╗  ██║██║   ██║██║██╔══██╗██╔═══██╗████╗  ██║████╗ ████║██╔════╝████╗  ██║╚══██╔══╝"; 
    CENTER "█████╗  ██╔██╗ ██║██║   ██║██║██████╔╝██║   ██║██╔██╗ ██║██╔████╔██║█████╗  ██╔██╗ ██║   ██║   "; 
    CENTER "██╔══╝  ██║╚██╗██║╚██╗ ██╔╝██║██╔══██╗██║   ██║██║╚██╗██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   "; 
    CENTER "███████╗██║ ╚████║ ╚████╔╝ ██║██║  ██║╚██████╔╝██║ ╚████║██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   "; 
    CENTER "╚══════╝╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝   "; 
    CENTER "                                                                                               ";
    ROWLIN
    CENTER "                       ${BLUE}System Environment Configuration${RESET}                         ";
    ROWLIN
    CENTER "                                                                                               ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Make Floder

    if [ ! -d "$HOME/workspace" ]; then mkdir -p "$HOME/workspace"; fi
    if [ ! -d "$HOME/desktop" ]; then mkdir -p "$HOME/desktop"; fi
    if [ ! -d "$HOME/.bin" ]; then mkdir -p "$HOME/.bin"; fi
    echo -e "\n\t\t${GREEN}[+]Make Folder Successful${RESET}\n"

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Set Locales Language

    ## sudo dpkg-reconfigure locales
    ## sudo locale-gen "zh_CN.UTF-8" > /dev/null 2>&1

    sudo sed -i -e 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/' /etc/locale.gen
    sudo locale-gen > /dev/null 2>&1
    sudo dpkg-reconfigure --frontend=noninteractive locales > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[+]Set Locales Language is Successful${RESET}\n"

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Set TimeZone

    sudo timedatectl set-timezone "Asia/Shanghai"
    echo -e "\n\t\t${GREEN}[+]Set TimeZone is Successful${RESET}\n"

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Fix Sanbox

    # echo 'kernel.unprivileged_userns_clone=1' | sudo tee /etc/sysctl.d/userns.conf > /dev/null 2>&1
    # echo -e "\t\t${GREEN}[+]Fix Error:chrome-sandbox is Successful${RESET}\n"

# --------------------------------------------------------------o----------------------------------------------------------------o

    # >>> Sudo user reboot options

    # sudo chmod u+s /sbin/reboot

}

# ================================================================================================================================
#                                                        SYSTEM - UPDATE
# ================================================================================================================================

System_Update() {

    ROWLIN
    CENTER "                                                     ";
    CENTER "███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗";
    CENTER "██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║";
    CENTER "███████╗ ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║";
    CENTER "╚════██║  ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║";
    CENTER "███████║   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║";
    CENTER "╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝";
    CENTER "                                                     ";
    ROWLIN
    CENTER "  ${BLUE}Repace Sources and System Update ${RESET}   ";
    ROWLIN
    CENTER "                                                     ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    sudo ln -sf "$DOTFILES_REPO/sources.list" "/etc/apt/sources.list"
    echo -e "\n\t\t${GREEN}[+]Repace sources.list Done !${RESET}\n"
    sudo apt update -y -qq > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[+]Update Successful !${RESET}\n"
    sudo apt upgrade -y -qq > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[+]Upgrade Successful !${RESET}\n"

}

# ================================================================================================================================
#                                                         APT - INSTALL
# ================================================================================================================================

Apt_Install() {

    ROWLIN
    CENTER "                            ";
    CENTER "  █████╗ ██████╗ ████████╗  ";
    CENTER " ██╔══██╗██╔══██╗╚══██╔══╝  ";
    CENTER " ███████║██████╔╝   ██║     ";
    CENTER " ██╔══██║██╔═══╝    ██║     ";
    CENTER " ██║  ██║██║        ██║     ";
    CENTER " ╚═╝  ╚═╝╚═╝        ╚═╝     ";
    CENTER "                            ";
    ROWLIN
    CENTER "${BLUE}Apt - Install${RESET}";
    ROWLIN
    CENTER "                            ";

# --------------------------------------------------------------o----------------------------------------------------------------o

	APTAPPS=( \
        i3 \
        feh \
        mpv \
        sxiv \
        rofi \
        picom \
        dunst \
        alttab \
        zathura \
        i3blocks \
        nautilus \
        dbus-x11 \
        i3lock-fancy \
        # deepin-screenshot \
        # nautilus --no-install-recommends --no-install-suggests \
        xinit \
        xorg-dev \
        lua5.2 \
        # ruby-full \
        # openssh-server \
        # openssh-client \
        fcitx \
        fcitx-pinyin \
        # language-pack-zh-hans \
        # language-pack-gnome-zh-hans \
        # open-vm-tools \
        open-vm-tools-desktop \
        jq \
        w3m \
        zip \
        htop \
        wget \
        curl \
        ncdu \
        unzip \
        xclip \
        wmctrl \
        ranger \
        xdotool \
        ripgrep \
        arc-theme
        hsetroot \
        newsboat \
        tty-clock \
        qutebrowser \
        python3-pip \
        inotify-tools \
        libgl1-mesa-* \
        bash-completion \
        # translate-shell \
        universal-ctags \
        silversearcher-ag \
        vim \
        tmux \
        vim-gtk \
        msmtp \
        neomutt \
        offlineimap \
        # peek \
        yank \
        imwheel
        # pv \
        # rar \
        # vlc \
        # bat \
        # xvfb \
        # tree \
        # axel \
        # unrar \
        # aria2 \
        # ffmpeg \
        # xinput \
        # ctags \
        # solaar \
        # compton \
        # i3status \
        # calibre \
        # dbus-x11 \
        # alacritty \
        # xautolock \
        # zlib1g-dev \ 
        # p7zip-full \
        # python-pip \
        # gnome-keyring \
        # libsecret-tools \
        # x11-xserver-utils \
        # fonts-wqy-microhei \
        # fcitx-module-cloudpinyin \
    )

    for app in "${APTAPPS[@]}"
    do
        echo -e "\n\t\t[*] Installing: $app";
        sudo apt install -y -qq $app > /dev/null 2>&1
        Install_Status $? $app
    done

}

# ================================================================================================================================
#                                                         PIP - INSTALL
# ================================================================================================================================

Pip_Install() {

    ROWLIN
    CENTER "                               ";
    CENTER "  ██████╗ ██╗██████╗ ██████╗   ";
    CENTER "  ██╔══██╗██║██╔══██╗╚════██╗  ";
    CENTER "  ██████╔╝██║██████╔╝ █████╔╝  ";
    CENTER "  ██╔═══╝ ██║██╔═══╝  ╚═══██╗  ";
    CENTER "  ██║     ██║██║     ██████╔╝  ";
    CENTER "  ╚═╝     ╚═╝╚═╝     ╚═════╝   ";
    CENTER "                               ";
    ROWLIN
    CENTER " ${BLUE}PIP3 - Install${RESET} ";
    ROWLIN
    CENTER "                               ";

# --------------------------------------------------------------o----------------------------------------------------------------o

	PIPAPPS=( \
        i3ipc \
        flake8 \
        #keyring \
        autotiling \
        ueberzug \
        raiseorlaunch \
        pygments==2.11.2 \
        #popupdict \
        you-get \
        pyvirtualdisplay 
        #mdv \
        #sncli \
        #pandas \
        #django \
        #litecli \
        #tabview \
        #you-get \
        #ipython \
        #xlsx2csv \
        #notebook \
        #selenium \
        #beautifulsoup4 \
        #prompt-toolkit \
        #powerline-shell \
    )

    for app in "${PIPAPPS[@]}"
    do
        echo -e "\n\t\t[*] Installing: $app";
        sudo pip3 install -q --timeout 1000 --retries 20  $app -i \
        https://pypi.tuna.tsinghua.edu.cn/simple > /dev/null 2>&1
        Install_Status $? $app
    done

}

# ================================================================================================================================
#                                                         DEB - INSTALL
# ================================================================================================================================

Deb_Install() {

    ROWLIN
    CENTER "                             ";
    CENTER "  ██████╗ ███████╗██████╗    ";
    CENTER "  ██╔══██╗██╔════╝██╔══██╗   ";
    CENTER "  ██║  ██║█████╗  ██████╔╝   ";
    CENTER "  ██║  ██║██╔══╝  ██╔══██╗   ";
    CENTER "  ██████╔╝███████╗██████╔╝   ";
    CENTER "  ╚═════╝ ╚══════╝╚═════╝    ";
    CENTER "                             ";
    ROWLIN
    CENTER "${BLUE}DEB - Install ${RESET}";
    ROWLIN
    CENTER "                             ";

# --------------------------------------------------------------o----------------------------------------------------------------o

	wget -P $SOURCE_DIR $GITHUBRAW/fd.deb > /dev/null 2>&1
	wget -P $SOURCE_DIR $GITHUBRAW/bat.deb > /dev/null 2>&1
	wget -P $SOURCE_DIR $GITHUBRAW/delta.deb > /dev/null 2>&1
	# wget -P $SOURCE_DIR $GITHUBRAW/foliate.deb > /dev/null 2>&1
	# wget -P $SOURCE_DIR $GITHUBRAW/Alacritty.deb > /dev/null 2>&1
	# wget -P $SOURCE_DIR $GITHUBRAW/timeshift.deb > /dev/null 2>&1
	
	DPKGAPPS=( \
        fd.deb \
        bat.deb \
        delta.deb
        # Alacritty.deb
    )

    for app in "${DPKGAPPS[@]}"
    do
        echo -e "\n\t\t[*] Installing: $app";
        sudo dpkg -i $SOURCE_DIR/$app > /dev/null 2>&1
        Install_Status $? $app
    done

}

# ================================================================================================================================
#                                                        TOOLS - INSTALL
# ================================================================================================================================

LoaclConfig() {

    ROWLIN
    CENTER "                                                ";
    CENTER "  ████████╗ ██████╗  ██████╗ ██╗     ███████╗   ";
    CENTER "  ╚══██╔══╝██╔═══██╗██╔═══██╗██║     ██╔════╝   ";
    CENTER "     ██║   ██║   ██║██║   ██║██║     ███████╗   ";
    CENTER "     ██║   ██║   ██║██║   ██║██║     ╚════██║   ";
    CENTER "     ██║   ╚██████╔╝╚██████╔╝███████╗███████║   ";
    CENTER "     ╚═╝    ╚═════╝  ╚═════╝ ╚══════╝╚══════╝   ";
    CENTER "                                                ";
    ROWLIN
    CENTER "${BLUE}Local Software- Config & Settings${RESET}";
    ROWLIN
    CENTER "                                                ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    #------------------------------------------------------------------------------------------------------------------------#   
    # Install ST (Terminal)       
    #------------------------------------------------------------------------------------------------------------------------#   

    # cd $HOME/.extras/install && ./setup "st"
    # echo -e "\t\t${GREEN}[√] ST - Terminal Successful${RESET}\n"

    #------------------------------------------------------------------------------------------------------------------------#   
    # Fcitx                         
    #------------------------------------------------------------------------------------------------------------------------#   

    im-config -n fcitx > /dev/null 2>&1
    im-config -s fcitx > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[√] Fcitx Successful${RESET}\n"
	
    #------------------------------------------------------------------------------------------------------------------------#   
    # Edge                              
    #------------------------------------------------------------------------------------------------------------------------#   

    #-----------------------------------------------------------o------------------------------------------------------------#   

    # >>> Setup

    curl -s https://packages.microsoft.com/keys/microsoft.asc \
        | gpg --dearmor > microsoft.gpg
    sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c \
        'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" \
        > /etc/apt/sources.list.d/microsoft-edge-dev.list' > /dev/null 2>&1
    sudo rm microsoft.gpg

    #-----------------------------------------------------------o------------------------------------------------------------#   

    # >>> Install

    sudo apt update -y -qq > /dev/null 2>&1
    sudo apt install -y -qq microsoft-edge-dev > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[√] Edge Successful${RESET}\n"

    #------------------------------------------------------------------------------------------------------------------------#   
    # Tmux                                
    #------------------------------------------------------------------------------------------------------------------------#   

    if [ ! -d "$HOME/.tmux" ]; then
        git clone -q https://${GITHUB}/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    fi
    
    tmux start-server
    tmux new-session -d
    $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1
    tmux kill-server
    echo -e "\n\t\t${GREEN}[√] TMUX Successful${RESET}\n"

    #------------------------------------------------------------------------------------------------------------------------#   
    # Install Vim Plug                      
    #------------------------------------------------------------------------------------------------------------------------#   

    vim
    echo -e "\n\t\t${GREEN}[√] Vim Successful${RESET}\n"

}

# ================================================================================================================================
#                                                        FONTS - INSTALL
# ================================================================================================================================

Fonts_Install() {

    ROWLIN
    CENTER "                                            ";
    CENTER "███████╗ ██████╗ ███╗   ██╗████████╗███████╗";
    CENTER "██╔════╝██╔═══██╗████╗  ██║╚══██╔══╝██╔════╝";
    CENTER "█████╗  ██║   ██║██╔██╗ ██║   ██║   ███████╗";
    CENTER "██╔══╝  ██║   ██║██║╚██╗██║   ██║   ╚════██║";
    CENTER "██║     ╚██████╔╝██║ ╚████║   ██║   ███████║";
    CENTER "╚═╝      ╚═════╝ ╚═╝  ╚═══╝   ╚═╝   ╚══════╝";
    CENTER "                                            ";
    ROWLIN
    CENTER "       ${BLUE}Fonts Install ${RESET}        ";
    ROWLIN
    CENTER "                                            ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    if [ ! -d "$HOME/.fonts" ]; then
        git clone -q\
            # https://${GITHUB}/hantaotaohan/fonts.git\
            https://gitee.com/hantaotaohan/fonts.git\
            $HOME/.fonts && cd $HOME/.fonts && ./install.sh
    else
        cd $HOME/.fonts &&\
        git reset -q --hard && git pull -q && ./install.sh
    fi

}

# ================================================================================================================================
#                                                        APT - CLEAR
# ================================================================================================================================

Apt_Remove() {

    ROWLIN
    CENTER "                                                     ";
    CENTER "██████╗ ███████╗███╗   ███╗ ██████╗ ██╗   ██╗███████╗";
    CENTER "██╔══██╗██╔════╝████╗ ████║██╔═══██╗██║   ██║██╔════╝";
    CENTER "██████╔╝█████╗  ██╔████╔██║██║   ██║██║   ██║█████╗  ";
    CENTER "██╔══██╗██╔══╝  ██║╚██╔╝██║██║   ██║╚██╗ ██╔╝██╔══╝  ";
    CENTER "██║  ██║███████╗██║ ╚═╝ ██║╚██████╔╝ ╚████╔╝ ███████╗";
    CENTER "╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝   ╚═══╝  ╚══════╝";
    CENTER "                                                     ";
    ROWLIN
    CENTER "            ${BLUE}Apt Remove ${RESET}               ";
    ROWLIN
    CENTER "                                                     ";
                                   
# --------------------------------------------------------------o----------------------------------------------------------------o

	APTAPPS=( \
        yelp \
        byobu \
        rxvt-unicode \
        gnome-terminal \
        xdg-desktop-portal-gtk 
    )

	for app in "${APTAPPS[@]}"
	do
        echo -e "\n\t\t[*] Remove: $app";
        sudo apt-get -y -qq --purge $app > /dev/null 2>&1
        sudo apt autoremove -y -qq > /dev/null 2>&1
        sudo apt-get clean > /dev/null 2>&1
        Install_Status $? $app
	done

}

# ================================================================================================================================
#                                                          STATUS - BOX
# ================================================================================================================================

Install_Status() {

    
    # CENTER "███████╗████████╗ █████╗ ████████╗██╗   ██╗███████╗";
    # CENTER "██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║   ██║██╔════╝";
    # CENTER "███████╗   ██║   ███████║   ██║   ██║   ██║███████╗";
    # CENTER "╚════██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║";
    # CENTER "███████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║";
    # CENTER "╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝";

# --------------------------------------------------------------o----------------------------------------------------------------o

	if [ $1 -eq 0 ]; then
        echo -e "\t\t${GREEN}[√] Install Success: $2${RESET}\n";
	else
        echo -e "\t\t${RED}[X] Install Failed: $2${RESET}\n";
	fi
	
}

# ================================================================================================================================
#                                                        HOSTS - INSTALL
# ================================================================================================================================

Install_Hosts() {

    ROWLIN
    CENTER "                                          ";
    CENTER "██╗  ██╗ ██████╗ ███████╗████████╗███████╗";
    CENTER "██║  ██║██╔═══██╗██╔════╝╚══██╔══╝██╔════╝";
    CENTER "███████║██║   ██║███████╗   ██║   ███████╗";
    CENTER "██╔══██║██║   ██║╚════██║   ██║   ╚════██║";
    CENTER "██║  ██║╚██████╔╝███████║   ██║   ███████║";
    CENTER "╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝";
    CENTER "                                          ";
    ROWLIN
    CENTER "       ${BLUE}HOSTS Install ${RESET}      ";
    ROWLIN
    CENTER "                                          ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    sudo sed -i "/# GitHub520 Host Start/Q" /etc/hosts && curl -s https://raw.hellogithub.com/hosts | sudo tee -a /etc/hosts > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[√] Hosts Repace Successful${RESET}\n"

}

# ================================================================================================================================
#                                                    SYNC - UPDATE - DOTFILES
# ================================================================================================================================

Sync_Dotfiles() {

    ROWLIN
    CENTER "                                                                                       ";
    CENTER " ██████╗ ██╗████████╗██╗  ██╗██╗   ██╗██████╗       ███████╗██╗   ██╗███╗   ██╗ ██████╗";
    CENTER "██╔════╝ ██║╚══██╔══╝██║  ██║██║   ██║██╔══██╗      ██╔════╝╚██╗ ██╔╝████╗  ██║██╔════╝";
    CENTER "██║  ███╗██║   ██║   ███████║██║   ██║██████╔╝█████╗███████╗ ╚████╔╝ ██╔██╗ ██║██║     ";
    CENTER "██║   ██║██║   ██║   ██╔══██║██║   ██║██╔══██╗╚════╝╚════██║  ╚██╔╝  ██║╚██╗██║██║     ";
    CENTER "╚██████╔╝██║   ██║   ██║  ██║╚██████╔╝██████╔╝      ███████║   ██║   ██║ ╚████║╚██████╗";
    CENTER " ╚═════╝ ╚═╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝       ╚══════╝   ╚═╝   ╚═╝  ╚═══╝ ╚═════╝";
    CENTER "                                                                                       ";
    ROWLIN
    CENTER "                            ${BLUE}Github Sync${RESET}                                 ";
    ROWLIN
    CENTER "                                                                                       ";

# --------------------------------------------------------------o----------------------------------------------------------------o

    git reset -q --hard && git pull -q
    echo -e "\n\t\t${GREEN} ● Dotfiles Update Sync Complete ${RESET}"
}

# ================================================================================================================================
#                                                        ECHO SUCCESSFUL
# ================================================================================================================================

Successful() {

    ROWLIN
    CENTER "${BLUE}                                                                                  ${RESET}";
    CENTER "${BLUE}███████╗██╗   ██╗ ██████╗ ██████╗███████╗███████╗███████╗███████╗██╗   ██╗██╗     ${RESET}";
    CENTER "${BLUE}██╔════╝██║   ██║██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝██╔════╝██║   ██║██║     ${RESET}";
    CENTER "${BLUE}███████╗██║   ██║██║     ██║     █████╗  ███████╗███████╗█████╗  ██║   ██║██║     ${RESET}";
    CENTER "${BLUE}╚════██║██║   ██║██║     ██║     ██╔══╝  ╚════██║╚════██║██╔══╝  ██║   ██║██║     ${RESET}";
    CENTER "${BLUE}███████║╚██████╔╝╚██████╗╚██████╗███████╗███████║███████║██║     ╚██████╔╝███████╗${RESET}";
    CENTER "${BLUE}╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝╚══════╝╚══════╝╚══════╝╚═╝      ╚═════╝ ╚══════╝${RESET}";
    CENTER "${BLUE}                                                                                  ${RESET}";
    ROWLIN

}

# ================================================================================================================================
#                                                    RUNNING - THIS - SCRIPT
# ================================================================================================================================

main() {

    Sync_Dotfiles

    case "$1" in
        ''|-h|--help)
            usage
            exit 0
            ;;
        -a|--all)
            Install_Dotfiles
            Workspace_Settings
            System_Update
            Apt_Install
            Install_Hosts
            Pip_Install
            Deb_Install
            LoaclConfig
            Fonts_Install
            Apt_Remove
            Successful
            cd $HOME
            bash
            ;;
        -d|--dotfiles)
            Install_Dotfiles
            bash
            ;;
        -D|--remove-dotfiles)
            Uninstall_Dotfiles
            bash
            ;;
        -w|--workspace)
            Workspace_Settings
            bash
            ;;
        -h|--hosts)
            Install_Hosts
            bash
            ;;
        -a|--apt)
            Apt_Install
            bash
            ;;
        -p|--pip)
            Pip_Install
            bash
            ;;
        -l|--local)
            LoaclConfig
            bash
            ;;
        -b|--deb)
            Deb_Install
            bash
            ;;
        -f|--fonts)
            Fonts_Install
            bash
            ;;
        -r|--remove)
            Apt_Remove
            bash
            ;;
        [qQ]) 
            exit; break 
            ;;
        *)
            echo -e"\nCommand not found" >&2
            exit 1
    esac
}
main "$@"
