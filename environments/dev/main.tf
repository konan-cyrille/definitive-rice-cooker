
locals {
  env = "dev"
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
