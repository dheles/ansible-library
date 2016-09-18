#!/usr/bin/env bash

function usage
{
  echo "usage: prereqs_apt [[[-a ADMIN ] | [-h]]"
}

# set defaults:
ADMIN="deploy"

# process arguments:
while [ "$1" != "" ]; do
  case $1 in
    -a | --admin )    shift
                      ADMIN=$1
                      ;;
    -h | --help )     usage
                      exit
                      ;;
    * )               usage
                      exit 1
  esac
  shift
done

echo "--> updating"
sudo apt-get update
sudo apt-get upgrade

echo "--> adding admin user $ADMIN..."
sudo useradd -m $ADMIN
id $ADMIN

echo "--> giving admin user passwordless sudo"
# sudo bash -c 'echo "$ADMIN ALL=(ALL) NOPASSWD: ALL" | (EDITOR="tee -a" visudo)'
if (! grep -q $ADMIN /etc/sudoers) ; then
  cp /etc/sudoers /tmp/sudoers.edit
  echo "$ADMIN ALL=(ALL) NOPASSWD: ALL" >> /tmp/sudoers.edit
  visudo -c -f /tmp/sudoers.edit
  if [ "$?" = "0" ] ; then
    cp /etc/sudoers /etc/sudoers.back
    cp /tmp/sudoers.edit /etc/sudoers
  fi
else
  echo "sudo already granted to $ADMIN"
fi

echo "--> checking SELinux status"
# sestatus
selinuxenabled
if [ "$?" = "0" ] ; then
  echo "selinux enabled. installing libselinux-python..."
  sudo apt-get install -y python-selinux
else
  echo "selinux not enabled"
fi
