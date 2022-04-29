terraform {
  backend "gcs" {
    bucket = "cicd-gcp-tools-348307-tfstate"
    prefix = "env/prod"
  }
}
