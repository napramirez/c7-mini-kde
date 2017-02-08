#!/bin/bash
#

sed -i 's/^SELINUX=.*$/SELINUX=permissive/g' /etc/selinux/config

rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum group install -y "X Window System" "Fonts"
yum install -y kde-workspace nodm

sed -i 's/^#NODM_USER=.*$/NODM_USER=vagrant/g' /etc/nodm.conf
echo "
#%PAM-1.0
auth     include login
account  include login
password include login
session  include login
" > /etc/pam.d/nodm

# The following line is needed to address this issue: https://bbs.archlinux.org/viewtopic.php?id=112580
su - vagrant -c 'mkdir -p ~/.local/share'

systemctl enable nodm
systemctl set-default graphical.target
systemctl reboot
