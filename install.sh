#!/bin/bash -e

# this install script is supposed to configure everything from a base non-lite
# raspberry os installation to the base configuration.

# needs to be run every week to make sure it's still up-to-date and won't fail
# when needed
# 
# goals:
#	- to install on 8GB of storage
#	- to install all the drivers needed
#	- to set up a secure environment
# 	- to set up the external storage if present

handler () {
    echo "An error has ocurred"
    exit 1
}

trap handler ERR

set -e

echo "Setting up the system..."
echo "..."

# make sure we have the right user set up
whoami | grep root >/dev/null
ls /home/magikarp >/dev/null
# ------------------------------------------------------------------------------

apt remove -y chromium-browser

apt install -y vim openssl
which vim
which openssl

# disable mouse acceleration, requires a reboot
# https://unix.stackexchange.com/questions/739758/how-to-disable-mouse-acceleration-on-raspberry-os-debian-11
sed -i '1 s/$/ usbhid\.mousepoll\=0/' /boot/cmdline.txt

# ------------------------------------------------------------------------------

# disable the wifi power management
# makes the connection a little better over ssh but might use more power
# permanent fix
cat > /etc/NetworkManager/conf.d/system-wifi-powersave.conf <<EOF
# File to be placed under /etc/NetworkManager/conf.d
# File name lexically later than 'default…'
[connection]
# Values for wifi.powersave are 
# 0 (use default), 1 (ignore/don't touch), 2 (disable) or 3 (enable).
wifi.powersave = 2
EOF
# for the current connection
iwconfig wlan0 power off
# make sure it's off
iwconfig 2>&1 | grep "Power Management:off" >/dev/null
# add script in the startup to make sure it's disabled
cat >> /home/magikarp/.bashrc <<EOF
set -e
iwconfig 2>&1 | grep "Power Management:off" >/dev/null || echo "[warn] Power management is enabled!"
set +e
EOF


# ------------------------------------------------------------------------------

apt upgrade -y
apt auto-remove -y


# ------------------------------------------------------------------------------

echo ""
echo "Finished successfully, time to reboot."
