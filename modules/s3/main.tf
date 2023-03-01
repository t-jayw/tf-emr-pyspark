resource "aws_s3_bucket" "scripts_bucket" {
  bucket = "${var.name}-scripts"
  acl    = "private"

  tags = {
    Name        = "Bucket for EMR Bootstrap actions/Steps"
    Environment = "Scripts"
  }
}

resource "aws_s3_bucket_object" "bootstrap_action_file" {
  bucket     = aws_s3_bucket.scripts_bucket.bucket
  key        = "scripts/bootstrap_actions.sh"
  source     = "scripts/bootstrap_actions.sh"
}

resource "aws_s3_bucket_object" "book_reviews_app" {
  bucket     = aws_s3_bucket.scripts_bucket.bucket
  key        = "scripts/amzn_review_analysis.py"
  source     = "scripts/amzn_review_analysis.py"
}

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

