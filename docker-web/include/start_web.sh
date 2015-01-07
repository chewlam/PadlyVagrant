#!/bin/sh

cd /root/src
/var/lib/gems/1.9.1/gems/rack-*/bin/rackup -p 4567 -o 0.0.0.0 -O DoNotReverseLookup config/config.ru