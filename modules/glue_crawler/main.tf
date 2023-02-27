resource "aws_iam_role" "glue_crawler_role" {
  name = "glue-crawler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "glue_crawler_policy" {
  name = "glue-crawler-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "glue_database_policy" {
  name        = "glue-database-policy"
  description = "Allows the AWS Glue service principal to access a specific database in the Glue Data Catalog."

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "glue:GetDatabase"
        Resource = "arn:aws:glue:us-east-1:*:catalog"
        Condition = {
          StringEquals = {
            "glue:DatabaseName" = var.glue_db_name
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_service_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  role       = aws_iam_role.glue_crawler_role.name
}

resource "aws_iam_role_policy_attachment" "glue_crawler_policy_attachment" {
  policy_arn = aws_iam_policy.glue_crawler_policy.arn
  role       = aws_iam_role.glue_crawler_role.name
}

resource "aws_iam_role_policy_attachment" "glue_crawler_cloudwatch" {
  role       = aws_iam_role.glue_crawler_role.name
  policy_arn = var.cloudwatch_allow_logging_policy_arn
}


resource "aws_glue_crawler" "glue_crawler" {
  name = "glue-crawler-${var.bucket_name}"
  database_name = var.glue_db_name
	role = aws_iam_role.glue_crawler_role.arn


  s3_target {
    path = "s3://${var.bucket_name}"
  }
}

