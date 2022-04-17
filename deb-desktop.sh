#!/bin/bash
#
# Debian workstation setup script
#
# My tweaks for desktop workstation. Could be adapted for Fedora/REL
# 
#
echo ""
echo '[+] Quick script to setup a debian desktop                   [+]'
echo ""
if ! [ $(id -u) = 0 ]; then
   echo "[+] Sorry, this needs to be run as sudo...                   [+]"
   echo "[+] Exiting now.                                             [+]"
   exit 1
fi
# Update repos and upgrade system packages
echo ""
echo '[+] Updating repos and upgrading packages...                 [+]'
cd /tmp
apt-get update -q
echo ""
DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade
echo ""
echo '[+] Removing unneeded packages...                            [+]'
DEBIAN_FRONTEND=noninteractive apt-get -q -y autoremove
#
# Adjust swappiness value for better performance, less swapping to disk #TODO check if value present, then sed to replace if so
echo '[+] Adjusting swappiness for better performance...           [+]'
echo "vm.swappiness=15" | sudo tee --append /etc/sysctl.conf
cat /proc/sys/vm/swappiness
#
# Move /tmp activity to RAM
echo ""
echo '[+] Moving all actions in /tmp to memory...                  [+]'
echo '# Move /tmp to RAM' | sudo tee --append /etc/fstab
echo 'tmpfs /tmp tmpfs defaults,noexec,nosuid 0 0' | sudo tee --append /etc/fstab
echo '/etc/fstab'
#
echo ""
echo '[+] Installing preload...                                    [+]'
apt-get install preload
# Clean up the home dir from default debian/ubuntu/kali folders
cd ~
rm -rf Videos/ Music/ Pictures/ Templates/
#
echo ""
echo '[+] Please reboot when this is finished. Enjoy!              [+]'
echo ""