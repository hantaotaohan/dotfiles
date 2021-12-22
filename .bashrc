# Add `~/bin` to the `$PATH`
# export PATH="$HOME/bin:$PATH";
export PATH="$HOME/debian/.extras/bin:$HOME/bin:$HOME/.local/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.

for file in ~/.{path,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
# 如果没有交互运行就不要做任何事情
case $- in
    *i*) ;;
      *) return;;
esac

# Autocorrect typos in path names when using `cd`.
# 使用"cd"时自动更正路径名中的键入错误.
shopt -s cdspell

# 如果命令为路径自动添加CD.
shopt -s autocd

# Case-insensitive globbing (used in pathname expansion).
# 不区分大小写的全局搜索(用于路径名扩展)
shopt -s nocaseglob

# append to the history file, don't overwrite it
# 附加到历史文件，不要覆盖它
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# 命令更新和检查错误设置
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# 如果设置了，在路径名扩展上下文中使用的模式“**”将              
# 匹配所有文件以及零个或多个目录和子目录。
shopt -s globstar

# 打开extglob模式
shopt -s extglob

# don't put duplicate lines or lines starting with space in the history.
# 不要在历史中放置重复的行或以空格开头的行。 
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# 历史长度信息设置
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
# 使非文本输入文件更加友好
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# 设置用于标识所用chroot的变量
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
# 设置颜色提示(非彩色，除非自定义颜色代码)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes
# 取消对彩色提示的注释(如果终端具有此功能):打开              
# 默认情况下关闭以不分散用户的注意力:终端窗口中的焦点              
# 应该在命令的输出上,而不是在提示符上              
# force_color_prompt=是

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# 默认bash.ps1设置
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# 如果判定终端为xterm，那么标题设置为user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
# 启用ls的颜色支持并添加方便的别名
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
# 彩色GCC警告和错误
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
# 为长时间运行的命令添加“警报”别名。像这样使用：              
# 睡眠10；提醒
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
# 别名定义。              
# 您可能希望将所有添加的内容放入一个单独的文件中，如              
# ~/.bash_别名，而不是直接添加到这里。              
# 请参见bash doc包中的/usr/share/doc/bash doc/examples。

#if [ -f ~/.aliases ]; then
#    . ~/.aliases
#fi

#if [ -f ~/.bash_prompt ]; then
#    . ~/.bash_prompt
#fi

#if [ -f ~/.exports ]; then
#    . ~/.exports
#fi

#[ -f ~/.exports ] && source ~/.exports
#[ -f ~/.aliases ] && source ~/.aliases
#[ -f ~/.bash_prompt ] && source ~/.bash_prompt
#[ -f ~/..functions ] && source ~/.functions


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# 启用可编程完成功能(不需要启用              
# 如果已经在/etc/bash.bashrc和/etc/profile中启用了这个              
# sources/etc/bash.bashrc)
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Install powerline-shell
# 设定powerline-shell

#function _update_ps1() {
#    PS1=$(powerline-shell $?)
#}

#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

# Install Z.sh
# 设定 z.sh
# source "$HOME/extras/z.sh"
# 设定 z.lua
[ -f ~/z.lua ] && eval "$(lua $HOME/z.lua --init bash enhanced fzf)"
export _ZL_CD=my_cd_func
set $_ZL_ECHO=0
set $_ZL_MATCH_MODE=1
set $_ZL_ROOT_MARKERS=".git,.svn,.hg,.root,package.json"

# Install FZF
# 安装FZF模糊所搜

[ -f ~/.fzf.bash ] && source ~/.fzf.bash 

# Xmodmap Install
# 用于xserver的键盘自定义
# 判断是否为桌面环境

if [ ! "$XDG_CURRENT_DESKTOP" = "" ]; then
    xmodmap "$HOME/.Xmodmap"
fi

# 为navi配置启动快捷键 CTRL+G
# if command -v navi >/dev/null 2>&1; then
#     source <(echo "$(navi widget bash)")
# fi

# 自定义颜色
red='\e[0;41m' # 红色  
RED='\e[1;31m' 
green='\e[0;32m' # 绿色  
GREEN='\e[1;32m' 
yellow='\e[5;43m' # 黄色  
YELLOW='\e[1;33m' 
blue='\e[0;34m' # 蓝色  
BLUE='\e[1;34m' 
purple='\e[0;35m' # 紫色  
PURPLE='\e[1;35m' 
cyan='\e[4;36m' # 蓝绿色  
CYAN='\e[1;36m' 
WHITE='\e[1;37m' # 白色
