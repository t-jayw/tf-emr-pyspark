Kind of a spin-off of this blog demoing pyspark on emr

https://medium.com/swlh/running-pyspark-applications-on-amazon-emr-e536b7a865ca

and used this blog as a starting point for the terraform which has been extended to match the above (mostly)

https://medium.com/idealo-tech-blog/using-terraform-to-quick-start-pyspark-on-aws-2bc8ce9dcac


Still will be using the same datasets (first bloglinks to kaggle sets) but resources like the s3 buckets will be named differently. 

look in the root modules variables.tf for vars you can set that will be applied throughout.
