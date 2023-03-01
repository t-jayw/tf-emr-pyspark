variable "name"  {
  type = string
  default = "tjw-spark-demo"
}

variable "infra_env" {
  type = string
  default = "dev"
}

variable "region"  {
  type = string
  default = "us-east-1"
}

variable "release_label" {
  type = string
  default = "emr-6.2.0"
}
variable "applications" {
  type = list(string)
  default = ["Hadoop", "Spark", "Presto", "Hive", "Livy", "JupyterEnterpriseGateway"]
}

variable "master_instance_type" {
  type = string
  default = "m5.xlarge"
}

variable "master_ebs_size" {
  type = number
  default = 32
}

variable "core_instance_type" {
  type = string
  default = "r5.2xlarge"
}

variable "core_instance_count" {
  type = number
  default = 2
}

variable "core_ebs_size" {
  type = number
  default = 32
}

variable "vpc_cidr_block" {
  type = string
  default = "10.1.0.0/16"
}

variable "ingress_cidr_blocks"  {
  type = string
  default = "0.0.0.0/0"
}
