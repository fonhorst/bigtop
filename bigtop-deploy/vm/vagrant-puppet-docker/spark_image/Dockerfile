FROM bigtop/ssh:centos-6.4

ADD hiera_settings.sh /hiera_settings.sh
RUN chmod 777 /hiera_settings.sh
RUN /hiera_settings.sh
RUN cd /bigtop-home && puppet apply --modulepath=./bigtop-deploy/puppet/modules -e "include spark::install_all" 

