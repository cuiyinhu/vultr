#!/bin/bash

oldname=ubuntu
newname=vlcyh
chmod 755 /home
sudo pkill -9 -u $oldname >>log.txt 2>&1  # 
sudo usermod -d /home/$newname -m $oldname >>log.txt 2>&1
usermod -l $newname $oldname >>log.txt 2>&1
groupmod -n $newname $oldname >>log.txt 2>&1
echo "1"
newname=vlcyh
#groupadd docker
#gpasswd -a $newname docker
#echo "1.1"   >log.txt 2>&1 
#newgrp docker

sudo usermod -a -G docker $newname  >>log.txt 2>&1 #将用户组追加到docker组

newname=vlcyh
echo "2"   >log.txt 2>&1 
sudo cp /etc/sudoers /etc/sudoers.bak
sudo chmod 220 /etc/sudoers
sudo echo "$newname ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sudo chmod 440 /etc/sudoers
sudo mkdir -p /home/$newname/.ssh
sudo cp /root/.ssh/authorized_keys /home/$newname/.ssh/
sudo chown -R $newname:$newname /home/$newname
echo "3"   >>log.txt 2>&1 
sudo chmod 750 /home/$newname
sudo chmod 700 /home/$newname/.ssh
sudo chmod 600 /home/$newname/.ssh/authorized_keys
echo "4"    >>log.txt 2>&1 
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
port=14320
ufw allow $port
sudo sed -i -e 's/^[#]\?Port\s\+\([1-9][0-9]*\).*$/Port '$port'/g' /etc/ssh/sshd_config
sudo sed -i -e 's/^[#]\?PermitRootLogin\s\+\(no\|yes\|prohibit-password\).*$/PermitRootLogin no/g' /etc/ssh/sshd_config
sudo sed -i -e 's/^[#]\?PubkeyAuthentication\s\+\(no\|yes\).*$/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i -e 's/^[#]\?PasswordAuthentication\s\+\(no\|yes\).*$/PasswordAuthentication no/g' /etc/ssh/sshd_config
sudo sed -i -e 's/^[#]\?PermitEmptyPasswords\s\+\(no\|yes\).*$/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
sudo systemctl restart sshd.service
echo "5"   >>log.txt 2>&1 
