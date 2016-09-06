# ad-hoc

Simple Vagrant project for standing up one or more servers to test ad-hoc Ansible commands (and whatnot)

Derived from my [deploy-test](https://github.com/dheles/deploy-test) project

Currently uses Centos 7 or Debian Jessie and sets up created VMs for management by Ansible

## preliminaries
### SSH config
Add something like the following to your ssh config (probably ~/.ssh/config):

NOTE: *only* for your local servers *not* for production boxes (or even stage, most likely)

    Host 10.11.12.* *.boxen.dev
    	StrictHostKeyChecking no
    	UserKnownHostsFile=/dev/null
    	User deploy
    	LogLevel ERROR
    	IdentityFile ~/.ssh/personal_dev

### SSH key
The previous version of this project used a file provisioner
to deploy a copy of your public ssh key to the VM.
The problem with this approach is that *sometimes*
the file provisioner hasn't done its job by the time the prereqs script runs.
when this happens, the key is not yet in its expected place to be moved over.
Instead, calling the authorize_key.rb script modified from
http://hakunin.com/six-ansible-practices.
This script just calls a file provisioner anyway, but
I believe that doing so in the same script that uses the file
ensures that the provisioning step completes before the next tries to use it...

### OS variable
Don't forget to set the OS variable in the Vagrantfile. Currently supports Debian and Centos

### Vagrant hostsupdater plugin
Recommended (but not required)
https://github.com/cogitatio/vagrant-hostsupdater
