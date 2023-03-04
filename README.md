# Standing up:
* Go through the root module variables.tf and update names and stuff

* Update your providers.tf for your own stuff

# What should happen:
All the infra spins up in your account. 

locally, update perms for the "myterrakey.pem" `chmod 400 myterrakey.pem` 

then you can ssh into the master node `ssh -i "myterrakey.pem" hadoop@<ip address>`

the IP address is dumped from outputs of the tf module. 

From there everything works and you can `spark-submit` python jobs, or run jupyter on your cluster


### resources

Kind of a spin-off of this blog demoing pyspark on emr

https://medium.com/swlh/running-pyspark-applications-on-amazon-emr-e536b7a865ca

and used this blog as a starting point for the terraform which has been extended to match the above (mostly)

https://medium.com/idealo-tech-blog/using-terraform-to-quick-start-pyspark-on-aws-2bc8ce9dcac


Still will be using the same datasets (first bloglinks to kaggle sets) but resources like the s3 buckets will be named differently. 

look in the root modules variables.tf for vars you can set that will be applied throughout.


