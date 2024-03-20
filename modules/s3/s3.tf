resource "aws_s3_bucket" "bucket" {
  
  force_destroy = true
    #bucket = "${var.name}-bucket"
    #bucket = "hallway-ohbster-01"

    #tags = var.tags
}
resource "aws_s3_bucket_ownership_controls" "object_ownership" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "acl" {
  depends_on = [aws_s3_bucket_ownership_controls.object_ownership]

  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_s3_bucket_policy" "policy" {
#   bucket = aws_s3_bucket.bucket.id
#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "AWS": "arn:aws:iam::127311923021:root"
#         },
#         "Action": "s3:PutObject",
#         "Resource": "${aws_s3_bucket.bucket.arn}"
#       }
#     ]
#   })
# }

