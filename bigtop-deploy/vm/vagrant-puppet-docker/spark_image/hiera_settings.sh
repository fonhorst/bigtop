#!/bin/bash

echo "Hello world!"

if [ -f /etc/debian_version ] ; then
    apt-get -y install puppet-module-puppetlabs-stdlib
    jdk="openjdk-7-jdk"
else
    cd /etc/puppet/modules && puppet module install puppetlabs/stdlib
    jdk="java-1.7.0-openjdk-devel.x86_64"
fi

mkdir -p /etc/puppet/hieradata
cp /bigtop-home/bigtop-deploy/puppet/hiera.yaml /etc/puppet
cp -r /bigtop-home/bigtop-deploy/puppet/hieradata/bigtop/ /etc/puppet/hieradata/
cat > /etc/puppet/hieradata/site.yaml << EOF
Bigtop::bigtop_yumrepo_uri: "http://bigtop01.cloudera.org:8080/view/Releases/job/Bigtop-0.8.0/label=centos6/6/artifact/output/"
bigtop::jdk_package_name: $jdk
EOF
