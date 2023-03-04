#!/bin/bash -xe

pyv="$(python3 -V 2>&1)"
echo "$pyv"

sudo yum install python3-pip -y

# # install some useful python packages
sudo python3 -m pip install \
    pandas \
    matplotlib \
    boto3 \
    jupyter \
    matplotlib \
    seaborn \
    ipython

# copy the scripts s3 bucket where we parked scripts
# aws s3 sync s3://$(aws s3 ls | grep scripts | cut -d' ' -f3) scripts

export foo=bar
