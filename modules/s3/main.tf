resource "aws_s3_bucket" "create_bucket" {
  bucket = "${var.name}"
  acl    = "private"

  tags = {
    Name        = "Bucket for EMR Bootstrap actions/Steps"
    Environment = "Scripts"
  }
}

resource "aws_s3_bucket_object" "bootstrap_action_file" {
  bucket     = "${var.name}"
  key        = "scripts/bootstrap_actions.sh"
  source     = "scripts/bootstrap_actions.sh"
  depends_on = ["aws_s3_bucket.create_bucket"]
}

/* resource "aws_s3_bucket_object" "pyspark_quick_setup_file" { */
/*   bucket     = "${var.name}" */
/*   key        = "scripts/pyspark_quick_setup.sh" */
/*   source     = "scripts/pyspark_quick_setup.sh" */
/*   depends_on = ["aws_s3_bucket.create_bucket"] */
/* } */

resource "aws_s3_bucket" "raw_bucket" {
  bucket = "${var.name}-raw-bucket"
  acl    = "private"

  tags = {
    Name        = "raw data bucket"
  }
}

resource "aws_s3_bucket" "processed_bucket" {
  bucket = "${var.name}-processed-bucket"
  acl    = "private"

  tags = {
    Name        = "processed data bucket"
  }
}

resource "aws_s3_bucket" "analyzed_bucket" {
  bucket = "${var.name}-analyzed-bucket"
  acl    = "private"

  tags = {
    Name        = "analyzed data bucket"
  }
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "${var.name}-logs-bucket"
  acl    = "private"

  tags = {
    Name        = "logs data bucket"
  }
}

