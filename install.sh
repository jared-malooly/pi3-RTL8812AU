#!/bin/sh

#from https://www.reddit.com/r/raspbian/comments/ew5i1c/rtl8812au/

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install dkms
sudo apt-get install bc raspberrypi-kernel-headers


cd ~/Downloads
git clone -b v5.6.4.2 https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au

sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
sed -i 's/CONFIG_PLATFORM_ARM_RPI = n/CONFIG_PLATFORM_ARM_RPI = y/g' Makefile
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile

sudo ./dkms-install.sh

#(takes a long time to complete)

sudo make

#(takes a long time to complete)

sudo make install

sudo apt-get install aircrack-ng
sudo airodump-ng-oui-update

sudo ip link set wlan1 down; sudo iw dev wlan1 set type monitor; sudo ip link set wlan1 up
sudo airodump-ng --band abg --manufacturer wlan1

sudo reboot
