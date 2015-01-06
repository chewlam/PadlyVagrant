#!/bin/bash

docker run -d -t -i -p 30022:22 -p 30080:4567 --link mongodb:mongodb --name web -v /vagrant/src:/root/src padly/web 


