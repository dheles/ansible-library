#!/usr/bin/env bash

function usage
{
  echo "usage: prereqs [[[-a ADMIN ] | [-h]]"
}

# set defaults:
SSH_USER="vagrant"
SSH_USER_HOME="/home/$SSH_USER"
ADMIN="deploy"
ADMIN_HOME="/home/$ADMIN"

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
sudo yum update

echo "--> adding admin user $ADMIN..."
sudo adduser $ADMIN
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

# # NOTE: moved to authorize_key.rb,
# echo "--> adding authorized_key..."
# if [ ! -f $ADMIN_HOME/.ssh/authorized_keys ]; then
#   sudo mkdir -p $ADMIN_HOME/.ssh
#   sudo touch $ADMIN_HOME/.ssh/authorized_keys
#   sudo bash -c "cat $SSH_USER_HOME/.ssh/authorized_key.pub >> $ADMIN_HOME/.ssh/authorized_keys"
#   sudo chown -R $ADMIN: $ADMIN_HOME/.ssh
#   sudo chmod 700 $ADMIN_HOME/.ssh
#   sudo chmod 600 $ADMIN_HOME/.ssh/*
# else
#   echo "authorized_key already added"
# fi

echo "--> checking SELinux status"
# sestatus
selinuxenabled
if [ "$?" = "0" ] ; then
  echo "selinux enabled. installing libselinux-python..."
  sudo yum install -y libselinux-python
else
  echo "selinux not enabled"
fi
