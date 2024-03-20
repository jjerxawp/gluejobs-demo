resource "aws_glue_catalog_database" "glue_data_catalog_db" {
  name = var.glue_data_catalog_db
}

resource "aws_glue_catalog_table" "glue_data_catalog_table" {
  name = var.demo_glue_data_table[0]
  database_name = aws_glue_catalog_database.glue_data_catalog_db.id
}

module "demo_s3" {
  source = "./s3_module"
  demo_glue_source = var.demo_glue_source
  demo_glue_target = var.demo_glue_target
  demo_glue_etl_code = var.demo_glue_etl_code
  demo_glue_crawler = var.demo_glue_crawler
  force_destroy = var.force_destroy
}

output "demo_glue_source_bucket_id" {
  value = module.demo_s3.demo_glue_source_id
}

output "demo_glue_target_bucket_id" {
  value = module.demo_s3.demo_glue_target_id
}

output "demo_glue_etl_code_bucket_id" {
  value = module.demo_s3.demo_glue_etl_code_id
}

output "demo_glue_crawler_bucket_id" {
  value = module.demo_s3.demo_glue_crawler_id
}


resource "aws_glue_crawler" "glue_demo_crawler_1" {
  database_name = aws_glue_catalog_database.glue_data_catalog_db.name
  name = var.demo_crawler_1_name

  s3_target {
    path = "s3://${demo_glue_crawler_bucket_id}/${var.demo_path_1}"
  }
}

variable "glue_data_catalog_db" {
  type = "string"
  default = "glue_data_catalog_db"
}

variable "demo_glue_data_table" {
  default = ["demo_citytemp"]
}

variable "demo_crawler_1_name" {
  type = string
  default = "demo-crawler-1"
}

variable "demo_path_1" {
  value = "demo1"
}