#!/bin/bash

etc=/mnt/etc
boot=/mnt/boot
echo "----------------------------------------"
echo "/mnt/etc/fstab"
echo "----------------------------------------"
cat $etc/fstab


echo "----------------------------------------"
echo "lsblk -f"
echo "----------------------------------------"
lsblk -f

echo "----------------------------------------"
echo "/boot/loader/entries/arch*.conf"
echo "----------------------------------------"
cat $boot/loader/entries/arch*.conf


echo "----------------------------------------"
echo "blkid -s PARTUUID -o value /dev/sdax"
echo "----------------------------------------"
echo "sda1"
blkid -s PARTUUID -o value /dev/sda1
echo "sda2"
blkid -s PARTUUID -o value /dev/sda2
echo "sda3"
blkid -s PARTUUID -o value /dev/sda3
echo "sda4"
blkid -s PARTUUID -o value /dev/sda4
echo "sda5"
blkid -s PARTUUID -o value /dev/sda5


echo "----------------------------------------"
echo "pacman --root=/mnt -Qkk"
echo "----------------------------------------"
pacman --root=/mnt -Qkk &> data/log
cat data/log
