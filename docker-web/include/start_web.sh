#!/bin/sh

cd /root/src
/var/lib/gems/1.9.1/gems/rack-1.5.2/bin/rackup -p 4567 -o 0.0.0.0 config.ru

