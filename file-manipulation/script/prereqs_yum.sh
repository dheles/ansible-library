#!/usr/bin/env bash

function usage
{
  echo "usage: prereqs_yum [[-l LOGIN_USER ] | [-h]]"
}

# set defaults:
LOGIN_USER="deploy"

# process arguments:
while [ "$1" != "" ]; do
  case $1 in
    -l | --login_user )   shift
                          LOGIN_USER=$1
                          ;;
    -h | --help )         usage
                          exit
                          ;;
    * )                   usage
                          exit 1
  esac
  shift
done

echo "--> updating"
sudo yum update

echo "--> adding login user $LOGIN_USER..."
sudo adduser $LOGIN_USER
id $LOGIN_USER

echo "--> giving login user passwordless sudo"
# sudo bash -c 'echo "$LOGIN_USER ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'
if (! grep -q $LOGIN_USER /etc/sudoers) ; then
  cp /etc/sudoers /tmp/sudoers.edit
  echo "$LOGIN_USER ALL=(ALL) NOPASSWD: ALL" >> /tmp/sudoers.edit
  visudo -c -f /tmp/sudoers.edit
  if [ "$?" = "0" ] ; then
    cp /etc/sudoers /etc/sudoers.back
    cp /tmp/sudoers.edit /etc/sudoers
  fi
else
  echo "sudo already granted to $LOGIN_USER"
fi

echo "--> checking SELinux status"
# sestatus
selinuxenabled
if [ "$?" = "0" ] ; then
  echo "selinux enabled. installing libselinux-python..."
  sudo yum install -y libselinux-python
else
  echo "selinux not enabled"
fi
