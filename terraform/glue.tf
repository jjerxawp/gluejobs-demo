resource "aws_glue_catalog_database" "glue_data_catalog_db" {
  name = var.glue_data_catalog_db
}

resource "aws_glue_catalog_table" "glue_data_catalog_table" {
  name = var.demo_glue_data_table[0]
  database_name = aws_glue_catalog_database.glue_data_catalog_db.id
}

variable "glue_data_catalog_db" {
  type = "string"
  default = "glue_data_catalog_db"
}

variable "demo_glue_data_table" {
  default = ["demo_citytemp"]
}