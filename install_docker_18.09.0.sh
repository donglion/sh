#!/bin/bash
sudo yum remove docker docker latest docker-latest-logrotate \
    docker-logrotate docker-engine docker-client docker-client-latest docker-common

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager \
    --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    
sudo yum makecache fast

sudo yum install -y docker-ce-18.09.0 docker-ce-cli-18.09.0 containerd.io

sudo systemctl start docker && sudo systemctl enable docker

echo "success"
