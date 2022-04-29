
locals {
  env = "prod"
}

provider "google" {
  project = "${var.project_id}"
}

module "gcs" {
  source  = "../../modules/gcs"
  project_id = "${var.project_id}"
  region  = "${var.region}"
  # env     = "${local.env}"
}


module "bigquery" {
  source  = "../../modules/bigquery"
  project_id = "${var.project_id}"
  region  = "${var.region}"
  # env     = "${local.env}"
}



# module "vpc" {
#   source  = "../../modules/vpc"
#   project = "${var.project}"
#   env     = "${local.env}"
# }

# module "http_server" {
#   source  = "../../modules/http_server"
#   project = "${var.project}"
#   subnet  = "${module.vpc.subnet}"
# }

# module "firewall" {
#   source  = "../../modules/firewall"
#   project = "${var.project}"
#   subnet  = "${module.vpc.subnet}"
# }
