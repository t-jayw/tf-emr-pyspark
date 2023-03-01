#!/bin/bash -xe

pyv="$(python3 -V 2>&1)"
echo "$pyv"

sudo yum install python3-pip -y

# # install some useful python packages
sudo pip3 install pandas matplotlib boto3

pip3 install jupyter
pip3 install jupyter_enterprise_gateway --ignore-installed PyYAML

