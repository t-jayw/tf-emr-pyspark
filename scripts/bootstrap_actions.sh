#!/bin/bash -xe

pyv="$(python3 -V 2>&1)"
echo "$pyv"

# # install some useful python packages
sudo python3 -m pip install --upgrade pip
sudo python3 -m pip install --user pandas matplotlib boto3

sudo python3 -m pip install jupyter

sudo python3 -m pip install jupyter_enterprise_gateway --ignore-installed PyYAML

