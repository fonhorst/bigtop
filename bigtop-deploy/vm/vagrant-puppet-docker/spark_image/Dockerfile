FROM bigtop/ssh:centos-6.4

ADD https://github.com/fonhorst/bigtop/archive/master.tar.gz /tmp/bigtop.tar.gz
RUN tar -xvf /tmp/bigtop.tar.gz -C / && rm -rf /bigtop-home && mv /bigtop-master /bigtop-home

ADD hiera_settings.sh /hiera_settings.sh
RUN chmod 777 /hiera_settings.sh
RUN /hiera_settings.sh 
RUN cd /bigtop-home && puppet apply -d --modulepath=/bigtop-home/bigtop-deploy/puppet/modules:/etc/puppet/modules:/usr/share/puppet/modules /bigtop-home/bigtop-deploy/puppet/manifests/installation.pp
