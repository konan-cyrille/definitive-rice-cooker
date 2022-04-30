# creation d'un dataset
resource "google_bigquery_dataset" "dataset_raw" {
  project                     = var.project_id
  dataset_id                  = "raw"
  friendly_name               = "raw"
  description                 = "le dataset de l'environnement de dev"
  location                    = var.region
}

# creation d'un dataset
resource "google_bigquery_dataset" "dataset_prepared" {
  project                     = var.project_id
  dataset_id                  = "prepared"
  description                 = "le dataset de l'environnement de dev"
  location                    = var.region
}

# creation d'un dataset
resource "google_bigquery_dataset" "dataset_sl_viz" {
  project                     = var.project_id
  dataset_id                  = "sl_viz"
  description                 = "le dataset de l'environnement de dev"
  location                    = var.region
}