#!/bin/bash
yum update -y
yum -y install epel-release python-pip
pip --version
pip install docker-compose
pip install --upgrade pip
# You are using pip version 8.1.2, however version 10.0.1 is available
python -m pip install --upgrade pip
