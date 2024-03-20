variable "policy" {
    type = string
    description = "iam::policy actions"
    default =  jsonencode({
        Version = "2012-10-17"
            Statement = [
            {
                Action = [
                "s3:ListBucket",
                ]
                Effect   = "Allow"
                Resource = "*"
            },
            ]
        })
  
}