#!/bin/bash
yum -y install wget httpd-tools
cat <<EOF >/etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/\$basearch/
gpgcheck=0
enabled=1
EOF
yum install nginx -y
systemctl start nginx.service
systemctl enable nginx.service
echo success
