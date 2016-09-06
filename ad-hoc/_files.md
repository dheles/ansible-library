#fetch files

    $ ansible app -s -m fetch -a "src=/etc/httpd/conf/httpd.conf dest=~/_temp"
    ansiblebox.boxen.dev | SUCCESS => {
        "changed": true,
        "checksum": "fdb1090d44c1980958ec96d3e2066b9a73bfda32",
        "dest": "/Users/dheles/_temp/ansiblebox.boxen.dev/etc/httpd/conf/httpd.conf",
        "md5sum": "f5e7449c0f17bc856e86011cb5d152ba",
        "remote_checksum": "fdb1090d44c1980958ec96d3e2066b9a73bfda32",
        "remote_md5sum": null
    }
