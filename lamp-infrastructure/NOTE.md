http://serverfault.com/questions/614787/varnish-wont-start-as-service-but-works-fine-from-command-line

looks like the default setup doesn't get along with selinux.
i've added a selinux playbook, that addressed part of the issue by installing libselinux-python, but apparently more work would be required to get varnish (at least) working on a selinux-enabled server. since i'm not sure how to go about crafting a policy for that, i've simply disabled selinux on all servers for the time being.
