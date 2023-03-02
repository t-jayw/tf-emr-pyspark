#! /bin/bash

rm -rf ~/logs; 
aws s3 cp --recursive s3://tjw-spark-demo-logs-bucket/$1/ ~/logs;
find ./logs -type f -exec gunzip {} \;
grep -inR "$2" logs/ | cut -d':' -f1

# aws s3 sync s3://$(aws s3 ls | grep script | cut -d' ' -f3)/scripts scripts
# 
