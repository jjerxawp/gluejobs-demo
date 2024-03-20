resource "aws_s3_bucket" "demo_glue_source" {
  bucket_prefix = var.demo_glue_source
  force_destroy = var.force_destroy
}

resource "null_resource" "upload_to_s3_demo_glue_source" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws s3 sync ../data/city_temperature.csv s3://${aws_s3_bucket.demo_glue_source.id}/ --delete --exclude '.DS_Store'"
  }
}


resource "aws_s3_bucket" "demo_glue_target" {
  bucket_prefix = var.demo_glue_target
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket" "demo_glue_etl_code" {
  bucket_prefix = var.demo_glue_etl_code
  force_destroy = var.force_destroy
}

resource "null_resource" "upload_to_s3_etl_code" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws s3 sync ../data/etl-code s3://${aws_s3_bucket.demo_glue_etl_code.id}/ --delete --exclude '.DS_Store'" 
  }
}

resource "aws_s3_bucket" "demo_glue_crawler" {
  bucket_prefix = var.demo_glue_crawler
  force_destroy = var.force_destroy
}

resource "null_resource" "upload_to_s3_crawler" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "aws s3 sync ../data/crawlerfiles s3://${aws_s3_bucket.demo_glue_crawler.id}/ --delete --exclude '.DS_Store'"
  }
}

output "demo_glue_source_id" {
  value = aws_s3_bucket.demo_glue_source.id
}

output "demo_glue_target_id" {
  value = aws_s3_bucket.demo_glue_target.id
}

output "demo_glue_etl_code_id" {
  value = aws_s3_bucket.demo_glue_etl_code.id
}

output "demo_glue_crawler_id" {
  value = aws_s3_bucket.demo_glue_crawler.id
}


variable "demo_glue_source" {
  type = string
  # default = "demo-glue-job-source"
}

variable "demo_glue_target" {
  type = string
  # default = "demo-glue-job-target"
}

variable "demo_glue_etl_code" {
  type = string
  # default = "demo-glue-etl-code"
}

variable "demo_glue_crawler" {
  type = string
  # default = "demo-glue-crawler"
}

variable "force_destroy" {
  # default = true
}
