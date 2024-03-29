resource "aws_glue_catalog_database" "glue_data_catalog_db" {
  name = var.glue_data_catalog_db
}

# resource "aws_glue_catalog_table" "glue_data_catalog_table" {
#   name = var.demo_glue_data_table[0]
#   database_name = aws_glue_catalog_database.glue_data_catalog_db.id
# }


module "demo_iam" {
  source = "./iam_module"
}

output "iam_glue_role_arn" {
  value = module.demo_iam.iam_glue_role_arn
}

# output "iam_s3_full_access_role_arn" {
#   value = module.demo_iam.iam_s3_full_access_role_arn
# }
# output "iam_s3_read_only_role_arn" {
#   value = module.demo_iam.iam_s3_read_only_role_arn
# }


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
  name = lookup(var.demo_crawler_name, "crawler_1")
  role = module.demo_iam.iam_glue_role_arn

  schema_change_policy {
    delete_behavior = "DELETE_FROM_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  s3_target {
    path = "s3://${module.demo_s3.demo_glue_crawler_id}/${lookup(var.demo_path, "crawler_1")}"
  }
}

resource "aws_glue_crawler" "glue_demo_crawler_2" {
  database_name = aws_glue_catalog_database.glue_data_catalog_db.name
  name = lookup(var.demo_crawler_name, "crawler_2")
  role = module.demo_iam.iam_glue_role_arn

  schema_change_policy {
    delete_behavior = "DELETE_FROM_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  s3_target {
    path = "s3://${module.demo_s3.demo_glue_crawler_id}/${lookup(var.demo_path, "crawler_2")}"
  }
}

resource "aws_glue_crawler" "glue_demo_crawler_3" {
  database_name = aws_glue_catalog_database.glue_data_catalog_db.name
  name = lookup(var.demo_crawler_name, "crawler_3")
  role = module.demo_iam.iam_glue_role_arn
  table_prefix = var.table_prefix_for_demo3

  schema_change_policy {
    delete_behavior = "DELETE_FROM_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  s3_target {
    path = "s3://${module.demo_s3.demo_glue_crawler_id}/${lookup(var.demo_path, "crawler_3")}"
  }
}

resource "aws_glue_crawler" "glue_demo_crawler_4" {
  database_name = aws_glue_catalog_database.glue_data_catalog_db.name
  name = lookup(var.demo_crawler_name, "crawler_4")
  role = module.demo_iam.iam_glue_role_arn

  schema_change_policy {
    delete_behavior = "DELETE_FROM_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  s3_target {
    path = "s3://${module.demo_s3.demo_glue_crawler_id}/${lookup(var.demo_path, "crawler_4")}"
    exclusions = ["current/**"]
  }
}

resource "aws_glue_crawler" "glue_demo_crawler_5" {
  database_name = aws_glue_catalog_database.glue_data_catalog_db.name
  name = lookup(var.demo_crawler_name, "crawler_5")
  role = module.demo_iam.iam_glue_role_arn

  schema_change_policy {
    delete_behavior = "DELETE_FROM_DATABASE"
    update_behavior = "UPDATE_IN_DATABASE"
  }

  s3_target {
    path = "s3://${module.demo_s3.demo_glue_crawler_id}/${lookup(var.demo_path, "crawler_5")}"
    exclusions = [
      "historical/**",
      "historical-year/**"
    ]
  }
}

variable "glue_data_catalog_db" {
  type = string
  default = "glue_data_catalog_db"
}

variable "demo_glue_data_table" {
  default = ["demo_citytemp"]
}

variable "demo_crawler_name" {
  type = map
  default = {
    crawler_1 = "demo-crawler-1",
    crawler_2 = "demo-crawler-2",
    crawler_3 = "demo-crawler-3",
    crawler_4 = "demo-crawler-4",
    crawler_5 = "demo-crawler-5"
  }
}

variable "demo_path" {
  type = map
  default = {
    crawler_1 = "demo1",
    crawler_2 = "demo2",
    crawler_3 = "demo3",
    crawler_4 = "demo4",
    crawler_5 = "demo4"
  }
}

variable "table_prefix_for_demo3" {
  type = string
  default = "demo-glue-"
}