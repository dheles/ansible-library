#!/usr/bin/env bash

# Import Remi GPG key.
wget http://rpms.famillecollet.com/RPM-GPG-KEY-remi -O /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi

# Install Remi repo.
rpm -Uvh --quiet http://rpms.remirepo.net/enterprise/remi-release-7.rpm

# Install EPEL repo.
yum install epel-release

# Install Node.js (npm plus all its dependencies).
yum --enablerepo=epel install node
