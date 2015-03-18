#!/usr/bin/env sh

echo "export HTTP_PROXY=http://proxy.ifmo.ru:3128" >> /var/lib/boot2docker/profile
echo "export http_proxy=http://proxy.ifmo.ru:3128" >> /var/lib/boot2docker/profile
/etc/init.d/docker restart
