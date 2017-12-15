#!/bin/bash

# 1. Installing ansible and misc packages
sudo yum install epel-release
sudo yum update
sudo yum install ansible vim git ssh

. ./ansible-admin.settings

if [ "${adduser}" -eq '0' ]; then
    echo "Done, skipping adding user"
    exit 0
fi

if [ -z "${password}" ]; then
    echo "ansible-admin.password file not found"
    exit 0
fi

# 2. Adding ansible-admin user, if specified
# Creating groups
groupCheckResult=`getent group admin`
if [ -z "${groupCheckResult}" ]; then
    echo "Creating admin group"
    sudo groupadd admin
    line='%admin ALL=(ALL) NOPASSWD: ALL'
    echo "${line}" > ./tmp.line
    sudo sh -c 'cat ./tmp.line > /etc/sudoers.d/admin'
    sudo rm ./tmp.line
fi

userCheckResult=`getent passwd ansible-admin`
if [ -z "${userCheckResult}" ]; then
    echo "Creating ansible-admin user"
    sudo useradd ansible-admin -G admin -m -s /bin/bash
fi

# Setting ansible-admin password
echo "ansible-admin:${password}" > ./tmp.password
sudo sh -c 'cat ./tmp.password | chpasswd'
sudo rm ./tmp.password
