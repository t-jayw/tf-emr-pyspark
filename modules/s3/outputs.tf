output "scripts_bucket" {
  value = aws_s3_bucket.scripts_bucket.bucket
}

output "raw_bucket" {
  value = aws_s3_bucket.raw_bucket.bucket
}

output "processed_bucket" {
  value = aws_s3_bucket.processed_bucket.bucket
}

output "logs_bucket" {
  value = aws_s3_bucket.logs_bucket.bucket
}
