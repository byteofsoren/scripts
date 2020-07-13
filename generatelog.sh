!#/bin/bash

echo "------------------------------"
echo "ping -c 2 ftp.acc.umu.se"
echo "------------------------------"
ping -c 2 ftp.acc.umu.se


echo "------------------------------"
echo "pacman -Qkk"
echo "------------------------------"
pacman -Qkk


echo "------------------------------"
echo "pacman -Syyu"
echo "------------------------------"
pacman -Syyu pacman


echo "------------------------------"
echo "find /mnt/usr/lib -size 0"
echo "------------------------------"
find /mnt/usr/lib -size 0

echo "done"
