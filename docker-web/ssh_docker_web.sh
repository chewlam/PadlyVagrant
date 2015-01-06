#!/bin/bash

#ssh-keygen -f "/home/vagrant/.ssh/known_hosts" -R [127.0.0.1]:30022
#ssh -q -p 30022 root@127.0.0.1

ssh -q -p 30022 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@127.0.0.1

