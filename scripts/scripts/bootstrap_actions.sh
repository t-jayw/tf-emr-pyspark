#!/bin/bash -xe

pyv="$(python3 -V 2>&1)"
echo "$pyv"

sudo yum install python3-pip -y

# # install some useful python packages
pip3 install --user pandas matplotlib boto3

pip3 install jupyter
# maybe installed in var.applications?
# pip3 install jupyter_enterprise_gateway --ignore-installed PyYAML

# copy the scripts s3 bucket where we parked scripts
# aws s3 sync s3://$(aws s3 ls | grep scripts | cut -d' ' -f3) scripts
