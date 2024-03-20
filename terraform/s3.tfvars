variable "demo_glue_source" {
  type = string
  default = "demo-glue-job-source"
}

variable "demo_glue_target" {
  type = string
  default = "demo-glue-job-target"
}

variable "demo_glue_etl_code" {
  type = string
  default = "demo-glue-etl-code"
}

variable "demo_glue_crawler" {
  type = string
  default = "demo-glue-crawler"
}

variable "force_destroy" {
  default = true
}
