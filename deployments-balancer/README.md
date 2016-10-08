# deployments-balancer

[official repo](https://github.com/geerlingguy/ansible-for-devops/blob/master/deployments-balancer/)

from Jeff Geerling's [Ansible for DevOps](http://ansiblefordevops.com/), with some additional monkeying about by myself.

REM: test load balancing:

    $ for i in {1..5}; do curl -Is http://ball.boxen.dev/ | grep Cookie; done
    Set-Cookie: SERVERID=10.11.12.103; path=/
    Set-Cookie: SERVERID=10.11.12.102; path=/
    Set-Cookie: SERVERID=10.11.12.103; path=/
    Set-Cookie: SERVERID=10.11.12.102; path=/
    Set-Cookie: SERVERID=10.11.12.103; path=/

disable proxying to one of the app servers:

    $ ansible-playbook playbooks/deploy.yml

confirm that it has been removed from rotation:

    $ for i in {1..5}; do curl -Is http://ball.boxen.dev/ | grep Cookie; done
    Set-Cookie: SERVERID=10.11.12.103; path=/
    Set-Cookie: SERVERID=10.11.12.103; path=/
    Set-Cookie: SERVERID=10.11.12.103; path=/
    Set-Cookie: SERVERID=10.11.12.103; path=/
    Set-Cookie: SERVERID=10.11.12.103; path=/
