resource "aws_s3_bucket" "bucket" {
    bucket = var.s3_bucket
    tags = var.mytags
}

variable "s3_bucket" {
    type = string
}