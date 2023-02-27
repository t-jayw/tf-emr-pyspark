output "bootstrap_bucket" {
  value = aws_s3_bucket.create_bucket.bucket
}

output "raw_bucket" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "logs_bucket" {
  value = aws_s3_bucket.logs_bucket.bucket
}
