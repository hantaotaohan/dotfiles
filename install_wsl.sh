#!/usr/bin/env bash

clear

#-----------------------------------------------------------------------------------------------------------#
# Setting Bash Colors Variable     
#-----------------------------------------------------------------------------------------------------------#

RED='\e[1;31m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
WHITE='\e[0;37m'
RESET='\e[0;37m'

#-----------------------------------------------------------------------------------------------------------#

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
RESET=$(tput sgr0)

#-----------------------------------------------------------------------------------------------------------#
# Setting Bash Ansi
#-----------------------------------------------------------------------------------------------------------#

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

#-----------------------------------------------------------------------------------------------------------#
# Start            
#-----------------------------------------------------------------------------------------------------------#

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
CENTER "   ${YELLOW}TaoTao - Debian - Wsl - Install${RESET}   ";
ROWLIN
CENTER "                                                      ";
CENTER "                                                      ";
CENTER "                                                      ";

#-----------------------------------------------------------------------------------------------------------#
# Setting Bash Variable              
#-----------------------------------------------------------------------------------------------------------#

BACKUP_DIR="$HOME/.dotfiles.orig"
BIN_DIR="$HOME/.local/bin"
DOTFILES_REPO=$(pwd)

[ -d "$BIN_DIR" ] || mkdir -p "$BIN_DIR" > /dev/null 2>&1

GITHUB="github.com"
GITHUBRAW="https://gitee.com/hantaotaohan/dotfiles/releases/download/1"
# GITHUBRAW="https://github.com/hantaotaohan/dotfiles/releases/download/1.0.0"

DOTFILES_COPY=( \
    .cargo \
    .config \
    .extras \
    .pip \
    .vim \
    .w3m \
    .aliases \
    .bash_profile \
    .bash_prompt \
    .bashrc \
    .ctags \
    .curlrc \
    .dircolors \
    .exports \
    .functions \
    .gemrc \
    .gitconfig \
    .gitignore \
    .inputrc \
    .msmtprc \
    .npmrc \
    .offlineimaprc \
    .ripgreprc \
    .tmux.conf \
    .vimrc \
    .wgetrc
)

#-----------------------------------------------------------------------------------------------------------#
# Setting Print usage message.         
#-----------------------------------------------------------------------------------------------------------#

usage() {
    local program_name
    program_name=${0##*/}
    cat <<EOF

Usage: $program_name [-option]

Options:

────────────────────────────────────────────────────────────────────────────────────────────
                                                                              
   -h        Print this message                                               
                                                                              
   -a        Install All                                                                     
                                                                              
────────────────────────────────────────────────────────────────────────────────────────────
                                                                              
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
                                                                              
────────────────────────────────────────────────────────────────────────────────────────────
                                                                            
EOF

}

#-----------------------------------------------------------------------------------------------------------#
# Start Install Dotfiles   
#-----------------------------------------------------------------------------------------------------------#

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

    # ─────────────────────────────────────────────────────────────────── #

    # >>> Backup Config.

    if ! [ -f "$BACKUP_DIR/check-backup.txt" ]; then
        env mkdir -p "$BACKUP_DIR/.config"
        cd "$BACKUP_DIR" || exit
        touch check-backup.txt

    # >>> Backup Some Folder In ~/.config To ~/.dotfiles.orig/.config

        for dots_copy in "${DOTFILES_COPY[@]//./}"
        do
            env cp -rf "$HOME/${dots_copy}" "$BACKUP_DIR/.config" &> /dev/null
        done

    # >>> Backup Again With Git.

        if [ -x "$(command -v git)" ]; then
            git init &> /dev/null
            git add -u &> /dev/null
            git add . &> /dev/null
            git commit -m "Backup original config on $(date '+%Y-%m-%d %H:%M')" &> /dev/null
        fi

    # >>> Output.

        echo -e "\t\t${BLUE}Your config is backed up in ${BACKUP_DIR}\n" >&2
        echo -e "\t\t${RED}Please do not delete check-backup.txt in .dotfiles.orig folder.${WHITE}" >&2
        echo -e "\t\tIt's used to backup and restore your old config.\n" >&2
    fi

    # >>> Install Move(CP) .config/ To $HOME/.config

    for dots_copy in "${DOTFILES_COPY[@]}"
    do
        sudo rm -rf "$HOME/${dots_copy}"
        cp -rf "$DOTFILES_REPO/${dots_copy}" "$HOME/"
    done

    # >>> Install Sources.list | .source To etc/apt/sources.list

    sudo ln -sf "$DOTFILES_REPO/sources.list" "/etc/apt/sources.list"
    echo -e "\n\t\t${GREEN}[+]Repace sources.list Done !${RESET}\n"

    # >>> Output.

    echo -e "\t\t${BLUE}New dotfiles is installed!\n${WHITE}" >&2
    echo -e "\t\tThere may be some errors when Terminal is restarted." >&2
    echo -e "\t\tPlease read carefully the error messages and make sure." >&2
    echo -e "\t\tall packages are installed. See more info in README.md." >&2
    echo -e "\t\tNote that the author of this dotfiles uses dev branch in some packages." >&2
    echo -e "\t\tIf you want to restore your old config, " >&2
    echo -e "\t\tyou can use ${RED}./install.sh -r${WHITE} command.\n" >&2
}

#-----------------------------------------------------------------------------------------------------------#
# Uninstall Dotfiles          
#-----------------------------------------------------------------------------------------------------------#

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

    # ───────────────────────────────────────────────────────────────────────────────────────── #

    if [ -f "$BACKUP_DIR/check-backup.txt" ]; then
        for dots_copy in "${DOTFILES_COPY[@]}"
        do
            env rm -rf "$HOME/${dots_copy}"
            env cp -rf "$BACKUP_DIR/${dots_copy}" "$HOME/" &> /dev/null
            env rm -rf "$BACKUP_DIR/${dots_copy}"
        done

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

#-----------------------------------------------------------------------------------------------------------#
# Workspace Settings      
#-----------------------------------------------------------------------------------------------------------#

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

    # ───────────────────────────────────────────────────────────────────────────────────────────────────── #

    # >>> Make Floder

    if [ ! -d "$HOME/workspace" ]; then mkdir -p "$HOME/workspace"; fi
    if [ ! -d "$HOME/desktop" ]; then mkdir -p "$HOME/desktop"; fi
    if [ ! -d "$HOME/.bin" ]; then mkdir -p "$HOME/.bin"; fi

    echo -e "\n\t\t${GREEN}[+]Make Folder Done !${RESET}\n"
}

#-----------------------------------------------------------------------------------------------------------#
# Repace Sources and System Update & Upgrade Packages        
#-----------------------------------------------------------------------------------------------------------#

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

    # ─────────────────────────────────────────────────────────── #

    sudo ln -sf "$DOTFILES_REPO/sources.list" "/etc/apt/sources.list"
    echo -e "\n\t\t${GREEN}[+]Repace sources.list Done !${RESET}\n"
    sudo apt update -y -qq > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[+]Update Successful !${RESET}\n"
    sudo apt upgrade -y -qq > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[+]Upgrade Successful !${RESET}\n"

}

#-----------------------------------------------------------------------------------------------------------#
# Apt - Install     
#-----------------------------------------------------------------------------------------------------------#

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

    # ────────────────────────────────── #

	APTAPPS=( \
        lua5.2 \
        openssh-server \
        openssh-client \
        jq \
        w3m \
        zip \
        htop \
        wget \
        curl \
        ncdu \
        unzip \
        ranger \
        ripgrep \
        newsboat \
        tty-clock \
        python3-pip \
        inotify-tools \
        universal-ctags \
        silversearcher-ag \
        vim \
        tmux \
        msmtp \
        neomutt \
        offlineimap \
        yank \
    )

    for app in "${APTAPPS[@]}"
    do
        echo -e "\n\t\t[*] Installing: $app";
        sudo apt install -y -qq $app > /dev/null 2>&1
        Install_Status $? $app
    done

}

#-----------------------------------------------------------------------------------------------------------#
# Pip3 - Install        
#-----------------------------------------------------------------------------------------------------------#

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

    # ───────────────────────────────────── #

	PIPAPPS=( \
        tldr \
        flake8 \
        pygments==2.11.2 \
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

#-----------------------------------------------------------------------------------------------------------#
# Local - Install & Config       
#-----------------------------------------------------------------------------------------------------------#

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

    # ─────────────────────────────────── #

	wget -P $BIN_DIR $GITHUBRAW/fd.deb > /dev/null 2>&1
	wget -P $BIN_DIR $GITHUBRAW/bat.deb > /dev/null 2>&1
	wget -P $BIN_DIR $GITHUBRAW/delta.deb > /dev/null 2>&1
	
	DPKGAPPS=( \
        fd.deb \
        bat.deb \
        delta.deb
    )

    for app in "${DPKGAPPS[@]}"
    do
        echo -e "\n\t\t[*] Installing: $app";
        sudo dpkg -i $BIN_DIR/$app > /dev/null 2>&1
        Install_Status $? $app
    done

}

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

    # ────────────────────────────────────────────────────── #

    #-------------------------------------------------------------------------------------------------------#
    # Tmux                                
    #-------------------------------------------------------------------------------------------------------#

    if [ ! -d "$HOME/.tmux" ]; then
        git clone -q https://${GITHUB}/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    fi
    
    tmux start-server
    tmux new-session -d
    $HOME/.tmux/plugins/tpm/scripts/install_plugins.sh > /dev/null 2>&1
    tmux kill-server
    echo -e "\n\t\t${GREEN}[√] TMUX Successful${RESET}\n"

    #-------------------------------------------------------------------------------------------------------#
    # Install Vim Plug                      
    #-------------------------------------------------------------------------------------------------------#

    vim
    echo -e "\n\t\t${GREEN}[√] Vim Successful${RESET}\n"

}

#-----------------------------------------------------------------------------------------------------------#
# Apt Remove        
#-----------------------------------------------------------------------------------------------------------#

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
                                   
    # ─────────────────────────────────────────────────────────── #

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

#-----------------------------------------------------------------------------------------------------------#
# Install - Status      
#-----------------------------------------------------------------------------------------------------------#

Install_Status() {

    
    # CENTER "███████╗████████╗ █████╗ ████████╗██╗   ██╗███████╗";
    # CENTER "██╔════╝╚══██╔══╝██╔══██╗╚══██╔══╝██║   ██║██╔════╝";
    # CENTER "███████╗   ██║   ███████║   ██║   ██║   ██║███████╗";
    # CENTER "╚════██║   ██║   ██╔══██║   ██║   ██║   ██║╚════██║";
    # CENTER "███████║   ██║   ██║  ██║   ██║   ╚██████╔╝███████║";
    # CENTER "╚══════╝   ╚═╝   ╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚══════╝";

    # ─────────────────────────────────────────────────────────── #

	if [ $1 -eq 0 ]; then
        echo -e "\t\t${GREEN}[√] Install Success: $2${RESET}\n";
	else
        echo -e "\t\t${RED}[X] Install Failed: $2${RESET}\n";
	fi
	
}

#-----------------------------------------------------------------------------------------------------------#
# Install - Hosts        
#-----------------------------------------------------------------------------------------------------------#

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

    # ──────────────────────────────────────────────── #

    sudo sed -i "/# GitHub520 Host Start/Q" /etc/hosts && curl -s https://raw.hellogithub.com/hosts | sudo tee -a /etc/hosts > /dev/null 2>&1
    echo -e "\n\t\t${GREEN}[√] Hosts Repace Successful${RESET}\n"

}

#-----------------------------------------------------------------------------------------------------------#
# Sync & Update - Dotfiles     
#-----------------------------------------------------------------------------------------------------------#

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
    CENTER "                            ${BLUE}Github Sync ${RESET}                                ";
    ROWLIN
    CENTER "                                                                                       ";

    # ───────────────────────────────────────────────────────────────────────────────────────────── #

    git reset -q --hard && git pull -q
    echo -e "\n\t\t${GREEN} ● Dotfiles Update Sync Complete ${RESET}"
}

#-----------------------------------------------------------------------------------------------------------#
# Running Bash in Install.sh     
#-----------------------------------------------------------------------------------------------------------#

main() {

#-----------------------------------------------------------------------------------------------------------#
# Auto Sync Dotfiles               
#-----------------------------------------------------------------------------------------------------------#

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
            Apt_Remove
            echo -e "\t\t${GREEN}[√] *** All Install Successful *** ${RESET}\n"
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
