module "s3" {
  source = "./modules/s3"
  name   = "${var.name}"
}

module "iam" {
  source = "./modules/iam"
}

module "network" {
  source = "./modules/network"
 
  infra_env = var.infra_env
 
  # So we're only using half of the available
  vpc_cidr  = var.vpc_cidr_block
}

module "security" {
  source              = "./modules/security"
  name                = "${var.name}"
  vpc_id              = module.network.vpc_id
  ingress_cidr_blocks = "${var.ingress_cidr_blocks}"
}

module "raw_crawler" {
  source              = "./modules/glue_crawler"
  bucket_name         = module.s3.raw_bucket
  glue_db_name        = module.glue_db.glue_db_name
  cloudwatch_allow_logging_policy_arn = module.iam.cloudwatch_allow_logging_policy_arn
}

module "glue_db" {
  source              = "./modules/glue_db"
  glue_catalog_database_name = "${var.name}-glue-db"
}

module "emr" {
  source                    = "./modules/emr"
  name                      = "${var.name}"
  release_label             = "${var.release_label}"
  applications              = "${var.applications}"
  subnet_id                 = module.network.vpc_public_subnet_ids[0]
  log_uri                   = module.s3.logs_bucket
  key_name                  = module.network.key_name
  master_instance_type      = "${var.master_instance_type}"
  master_ebs_size           = "${var.master_ebs_size}"
  core_instance_type        = "${var.core_instance_type}"
  core_instance_count       = "${var.core_instance_count}"
  core_ebs_size             = "${var.core_ebs_size}"
  emr_master_security_group = "${module.security.emr_master_security_group}"
  emr_slave_security_group  = "${module.security.emr_slave_security_group}"
  emr_ec2_instance_profile  = "${module.iam.emr_ec2_instance_profile}"
  emr_service_role          = "${module.iam.emr_service_role}"
  emr_autoscaling_role      = "${module.iam.emr_autoscaling_role}"
}

