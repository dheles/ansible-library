#### ping test

    $ ansible all -m ping
    app.boxen.dev | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    db.boxen.dev | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }
    solr.boxen.dev | SUCCESS => {
        "changed": false,
        "ping": "pong"
    }

#### serial command execution

    $ ansible all -a "hostname" -f 1
    app.boxen.dev | SUCCESS | rc=0 >>
    app.boxen.dev

    db.boxen.dev | SUCCESS | rc=0 >>
    db.boxen.dev

    solr.boxen.dev | SUCCESS | rc=0 >>
    solr.boxen.dev

#### disk usage

    $ ansible all -a "df -h"

#### memory monitoring

    $ ansible all -a "free -m"
    db.boxen.dev | SUCCESS | rc=0 >>
              total        used        free      shared  buff/cache   available
    Mem:            237          75           3           5         157         128
    Swap:          1535           3        1532

    app.boxen.dev | SUCCESS | rc=0 >>
              total        used        free      shared  buff/cache   available
    Mem:            237          73           5           5         157         130
    Swap:          1535           3        1532

    solr.boxen.dev | SUCCESS | rc=0 >>
              total        used        free      shared  buff/cache   available
    Mem:            237          75          24           5         137         128
    Swap:          1535           3        1532

#### time check

    $ ansible all -a "date"
    db.boxen.dev | SUCCESS | rc=0 >>
    Mon Sep  5 17:15:45 UTC 2016

    solr.boxen.dev | SUCCESS | rc=0 >>
    Mon Sep  5 17:15:45 UTC 2016

    app.boxen.dev | SUCCESS | rc=0 >>
    Mon Sep  5 17:15:45 UTC 2016

#### install stuff
prolly better to use a playbook, but you never know...

    $ ansible all -s -m yum -a "name=ntp state=present"
    # much output...

2nd run:

    $ ansible all -s -m yum -a "name=ntp state=present"
      db.boxen.dev | SUCCESS => {
      "changed": false,
      "msg": "",
      "rc": 0,
      "results": [
          "ntp-4.2.6p5-22.el7.centos.2.x86_64 providing ntp is already installed"
      ]
    }
    app.boxen.dev | SUCCESS => {
      "changed": false,
      "msg": "",
      "rc": 0,
      "results": [
          "ntp-4.2.6p5-22.el7.centos.2.x86_64 providing ntp is already installed"
      ]
    }
    solr.boxen.dev | SUCCESS => {
      "changed": false,
      "msg": "",
      "rc": 0,
      "results": [
          "ntp-4.2.6p5-22.el7.centos.2.x86_64 providing ntp is already installed"
      ]
    }

#### start a service

    $ ansible all -s -m service -a "name=ntpd state=started enabled=yes"
    db.boxen.dev | SUCCESS => {
        "changed": true,
        "enabled": true,
        "name": "ntpd",
        "state": "started"
    }
    app.boxen.dev | SUCCESS => {
        "changed": true,
        "enabled": true,
        "name": "ntpd",
        "state": "started"
    }
    solr.boxen.dev | SUCCESS => {
        "changed": true,
        "enabled": true,
        "name": "ntpd",
        "state": "started"
    }

2nd run:

    $ ansible all -s -m service -a "name=ntpd state=started enabled=yes"
    solr.boxen.dev | SUCCESS => {
        "changed": false,
        "enabled": true,
        "name": "ntpd",
        "state": "started"
    }
    app.boxen.dev | SUCCESS => {
        "changed": false,
        "enabled": true,
        "name": "ntpd",
        "state": "started"
    }
    db.boxen.dev | SUCCESS => {
        "changed": false,
        "enabled": true,
        "name": "ntpd",
        "state": "started"
    }

#### adjust a service

stop

    $ ansible all -s -a "service ntpd stop"
    app.boxen.dev | SUCCESS | rc=0 >>
    Redirecting to /bin/systemctl stop  ntpd.service

    db.boxen.dev | SUCCESS | rc=0 >>
    Redirecting to /bin/systemctl stop  ntpd.service

    solr.boxen.dev | SUCCESS | rc=0 >>
    Redirecting to /bin/systemctl stop  ntpd.service

adjust

    $ ansible all -s -a "ntpdate -q 0.rhel.pool.ntp.org"
    app.boxen.dev | SUCCESS | rc=0 >>
    server 45.127.113.2, stratum 2, offset -0.005516, delay 0.05162
    server 52.41.67.45, stratum 2, offset -0.001611, delay 0.12143
    server 208.53.158.34, stratum 3, offset -0.006534, delay 0.05861
    server 97.107.128.58, stratum 2, offset -0.005580, delay 0.04126
     5 Sep 17:27:33 ntpdate[31738]: adjust time server 97.107.128.58 offset -0.005580 sec 5 Sep 17:27:29 ntpdate[31738]: 52.41.67.45 rate limit response from server.

    db.boxen.dev | SUCCESS | rc=0 >>
    server 152.2.133.52, stratum 1, offset -0.012812, delay 0.07872
    server 204.2.134.164, stratum 0, offset 0.000000, delay 0.00000
    server 66.228.42.59, stratum 3, offset -0.006534, delay 0.04135
    server 66.228.59.187, stratum 0, offset 0.000000, delay 0.00000
     5 Sep 17:27:35 ntpdate[12684]: adjust time server 152.2.133.52 offset -0.012812 sec 5 Sep 17:27:27 ntpdate[12684]: 66.228.59.187 rate limit response from server.

    solr.boxen.dev | SUCCESS | rc=0 >>
    server 204.2.134.164, stratum 3, offset -0.012228, delay 0.12865
    server 66.228.42.59, stratum 3, offset -0.004843, delay 0.04088
    server 66.228.59.187, stratum 2, offset -0.004943, delay 0.05389
    server 152.2.133.52, stratum 1, offset -0.013013, delay 0.07539
     5 Sep 17:27:35 ntpdate[12684]: adjust time server 152.2.133.52 offset -0.013013 sec

 restart

     $ ansible all -s -a "service ntpd start"
    solr.boxen.dev | SUCCESS | rc=0 >>
    Redirecting to /bin/systemctl start  ntpd.service

    db.boxen.dev | SUCCESS | rc=0 >>
    Redirecting to /bin/systemctl start  ntpd.service

    app.boxen.dev | SUCCESS | rc=0 >>
    Redirecting to /bin/systemctl start  ntpd.service

#### examine a file

    $ ansible all -m stat -a "path=/etc/environment"
    db.boxen.dev | SUCCESS => {
        "changed": false,
        "stat": {
            "atime": 1473094907.0972166,
            "checksum": "da39a3ee5e6b4b0d3255bfef95601890afd80709",
            "ctime": 1469793028.004,
            "dev": 64768,
            "exists": true,
            "gid": 0,
            "gr_name": "root",
            "inode": 2228260,
            "isblk": false,
            "ischr": false,
            "isdir": false,
            "isfifo": false,
            "isgid": false,
            "islnk": false,
            "isreg": true,
            "issock": false,
            "isuid": false,
            "md5": "d41d8cd98f00b204e9800998ecf8427e",
            "mode": "0644",
            "mtime": 1439389312.0,
            "nlink": 1,
            "path": "/etc/environment",
            "pw_name": "root",
            "rgrp": true,
            "roth": true,
            "rusr": true,
            "size": 0,
            "uid": 0,
            "wgrp": false,
            "woth": false,
            "wusr": true,
            "xgrp": false,
            "xoth": false,
            "xusr": false
        }
    }
    # ... etc

#### update

-s is for sudo
-B 3600 is for run in the background and give the process 3600 seconds to complete

    $ ansible all -s -B 3600 -a "yum -y update"
    # ...heaps of output

2nd run:

    $ ansible all -s -B 3600 -a "yum -y update"
    app.boxen.dev | SUCCESS | rc=0 >>
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: linux.cc.lehigh.edu
     * extras: mirror.math.princeton.edu
     * updates: mirror.math.princeton.edu
    No packages marked for update

    solr.boxen.dev | SUCCESS | rc=0 >>
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirror.umd.edu
     * extras: mirror.umd.edu
     * updates: mirror.symnds.com
    No packages marked for update

    db.boxen.dev | SUCCESS | rc=0 >>
    Loaded plugins: fastestmirror
    Loading mirror speeds from cached hostfile
     * base: mirror.cs.vt.edu
     * extras: mirror.umd.edu
     * updates: mirror.symnds.com
    No packages marked for update

### logging
#### basic

    $ ansible all -s -a "tail /var/log/messages"
    db.boxen.dev | SUCCESS | rc=0 >>
    Sep  5 17:35:04 localhost ansible-async_wrapper: Module complete (10329)
    Sep  5 17:35:08 localhost ansible-async_wrapper: Done in kid B.
    Sep  5 17:36:19 localhost systemd-logind: Removed session 15.
    Sep  5 17:36:19 localhost systemd: Removed slice user-1001.slice.
    Sep  5 17:36:19 localhost systemd: Stopping user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Created slice user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Starting user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Started Session 16 of user deploy.
    Sep  5 17:39:28 localhost systemd-logind: New session 16 of user deploy.
    Sep  5 17:39:28 localhost systemd: Starting Session 16 of user deploy.

    solr.boxen.dev | SUCCESS | rc=0 >>
    Sep  5 17:35:04 localhost ansible-async_wrapper: Module complete (10326)
    Sep  5 17:35:08 localhost ansible-async_wrapper: Done in kid B.
    Sep  5 17:36:19 localhost systemd-logind: Removed session 15.
    Sep  5 17:36:19 localhost systemd: Removed slice user-1001.slice.
    Sep  5 17:36:19 localhost systemd: Stopping user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Created slice user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Starting user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Started Session 16 of user deploy.
    Sep  5 17:39:28 localhost systemd-logind: New session 16 of user deploy.
    Sep  5 17:39:28 localhost systemd: Starting Session 16 of user deploy.

    app.boxen.dev | SUCCESS | rc=0 >>
    Sep  5 17:35:04 localhost ansible-async_wrapper: Module complete (29395)
    Sep  5 17:35:08 localhost ansible-async_wrapper: Done in kid B.
    Sep  5 17:36:19 localhost systemd-logind: Removed session 17.
    Sep  5 17:36:19 localhost systemd: Removed slice user-1001.slice.
    Sep  5 17:36:19 localhost systemd: Stopping user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Created slice user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Starting user-1001.slice.
    Sep  5 17:39:28 localhost systemd: Started Session 18 of user deploy.
    Sep  5 17:39:28 localhost systemd-logind: New session 18 of user deploy.
    Sep  5 17:39:28 localhost systemd: Starting Session 18 of user deploy.

### with pipes
must use the shell module to pipe stuff

    $ ansible all -s -m shell -a "tail /var/log/messages | grep deploy | wc -l"
    db.boxen.dev | SUCCESS | rc=0 >>
    5

    solr.boxen.dev | SUCCESS | rc=0 >>
    5

    app.boxen.dev | SUCCESS | rc=0 >>
    5

or maybe

    $ ansible all -s -m shell -a "tail /var/log/messages | grep deploy"
    solr.boxen.dev | SUCCESS | rc=0 >>
    Sep  5 17:39:28 localhost systemd-logind: New session 16 of user deploy.
    Sep  5 17:39:28 localhost systemd: Starting Session 16 of user deploy.
    Sep  5 17:41:24 localhost systemd: Started Session 17 of user deploy.
    Sep  5 17:41:24 localhost systemd-logind: New session 17 of user deploy.
    Sep  5 17:41:24 localhost systemd: Starting Session 17 of user deploy.

    app.boxen.dev | SUCCESS | rc=0 >>
    Sep  5 17:39:28 localhost systemd-logind: New session 18 of user deploy.
    Sep  5 17:39:28 localhost systemd: Starting Session 18 of user deploy.
    Sep  5 17:41:24 localhost systemd: Started Session 19 of user deploy.
    Sep  5 17:41:24 localhost systemd-logind: New session 19 of user deploy.
    Sep  5 17:41:24 localhost systemd: Starting Session 19 of user deploy.

    db.boxen.dev | SUCCESS | rc=0 >>
    Sep  5 17:39:28 localhost systemd-logind: New session 16 of user deploy.
    Sep  5 17:39:28 localhost systemd: Starting Session 16 of user deploy.
    Sep  5 17:41:24 localhost systemd: Started Session 17 of user deploy.
    Sep  5 17:41:24 localhost systemd-logind: New session 17 of user deploy.
    Sep  5 17:41:24 localhost systemd: Starting Session 17 of user deploy.
