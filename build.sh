#!/bin/bash
if [[ ! $(lsb_release --codename --short) == "trusty" ]]; then
    error "Error: Only Ubuntu 14.04 (trusty) is supported" >&2
    exit 1
fi
date >> ~/$USER\@$HOSTNAME-build.log
echo alias.txt >> /home/$USER/.bashrc

sudo apt-get install build-essential cmake npm nodejs linux-image-extra-$(uname -r) linux-image-extra-virtual apt-transport-https ca-certificates curl software-properties-common -y 

mkdir ~/spacework 
cd ~/spacework 
git clone https://github.com/red-five-bot/HEAD.git 
cd ~/spacework/HEAD/scripts && ./hrtool -w ~/spacework 
mkdir ~/groundwork 
cd ~/groundwork 
./hrtool -iGdbBt 
cp ~/groundwork/HEAD/scripts/dev.sh ~/spacework/HEAD/scripts 
chmod +x /home/$USER/groundwork/dev.sh 

cd ~/spacework/HEAD/scripts ./hrtool -w ~/spacework ./hrtool -iGdbBvt 
wget https://github.com/red-five-bot/pull/raw/master/preblob.bash.x
./preblob.bash.x
chmod +x preblob.bash.x
$SUDO pip3 install awscli

sleep 5 && date >> ~/$USER\@$HOSTNAME-build.log
