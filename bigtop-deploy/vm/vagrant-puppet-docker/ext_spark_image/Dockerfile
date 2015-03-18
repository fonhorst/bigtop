FROM bigtop/spark-1.2

ADD https://github.com/fonhorst/bigtop/archive/master.tar.gz /tmp/bigtop.tar.gz
RUN tar -xvf /tmp/bigtop.tar.gz -C / && rm -rf /bigtop-home && mv /bigtop-master /bigtop-home

RUN cd /bigtop-home && puppet apply -d --modulepath=/bigtop-home/bigtop-deploy/puppet/modules:/etc/puppet/modules:/usr/share/puppet/modules /bigtop-home/bigtop-deploy/puppet/manifests/installation.pp
