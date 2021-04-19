sudo rm -rf /etc/apt/sources.list &&\
sudo bash -c "echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse > /etc/apt/sources.list" &&\
sudo bash -c "echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse >> /etc/apt/sources.list" &&\
sudo bash -c "echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse >> /etc/apt/sources.list" &&\
sudo bash -c "echo deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse >> /etc/apt/sources.list" &&\
sudo apt-get update -y &&\
sudo apt install git -y &&\
git clone https://github.com/hantaotaohan/Dotfiles.git &&\
cd $HOME/Dotfiles &&\
./install.sh
