Kind of a spin-off of this blog demoing pyspark on emr

https://medium.com/swlh/running-pyspark-applications-on-amazon-emr-e536b7a865ca

But all the infra is spun up w/ terraform -- so not exactly the same. 

Still will be using the same datasets (he links to kaggle sets) but resources like the s3 buckets will be named differently. 

look in the root modules variables.tf for vars you can set that will be applied throughout.
