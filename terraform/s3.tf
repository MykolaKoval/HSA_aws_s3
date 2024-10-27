# Ledger bucket
resource "aws_s3_bucket" "ledger" {
  bucket = "smith-hsa-ledger"
}

resource "aws_s3_bucket_versioning" "ledger_versioning" {
  bucket = aws_s3_bucket.ledger.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "ledger_locking" {
  bucket = aws_s3_bucket.ledger.id

  rule {
    default_retention {
      mode = "COMPLIANCE"
      days = 1 # Set years to increase retention period
    }
  }
  depends_on = [aws_s3_bucket_versioning.ledger_versioning]
}

resource "aws_s3_bucket_logging" "ledger_logging" {
  bucket = aws_s3_bucket.ledger.id

  target_bucket = aws_s3_bucket.ledger_log.id
  target_prefix = "logs/"
}

# Ledger bucket access logs
resource "aws_s3_bucket" "ledger_log" {
  bucket = "smith-hsa-ledger-log"
}

resource "aws_s3_bucket_policy" "allow_write_bucket_access_logs" {
  bucket = aws_s3_bucket.ledger_log.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3ServerAccessLogsPolicy",
            "Effect": "Allow",
            "Principal": {
                "Service": "logging.s3.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "${aws_s3_bucket.ledger_log.arn}/*"
        }
    ]
}
  EOF
}