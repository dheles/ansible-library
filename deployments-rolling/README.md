# Node.js App Deployment Demo

[official repo](https://github.com/geerlingguy/ansible-for-devops/tree/master/deployments-rolling)

from Jeff Geerling's [Ansible for DevOps](http://ansiblefordevops.com/), with some additional monkeying about by myself.

NOTE:
this one isn't currently working, either.
even after working around the movement in the required node role, i'm still getting the following error:

TASK [Get list of all running Node.js apps.] ***********************************
fatal: [192.168.3.2]: FAILED! => {"changed": false, "cmd": "forever list", "failed": true, "msg": "[Errno 2] No such file or directory", "rc": 2}
