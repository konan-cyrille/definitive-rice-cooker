
# Creation d'une ressource bucket qui contiendra les différents fichier
resource "google_storage_bucket" "bucket-auto-expire-in" {
  name          = "bkt-${var.project_id}-in"
  project       = var.project_id
  location      = var.region
  force_destroy = true

  # au bout de combien de jour le bucket sera detruit (au bout de 15J)
  # commenter le bloc lifecycle_rule si on ne veut pas que le bucket soit supprimé
  lifecycle_rule {
    condition {
      age = 15
    }
    action {
      type = "Delete"
    }
  }
}

# au bout de combien de jour le bucket sera detruit (au bout de 15J)
# commenter le bloc lifecycle_rule si on ne veut pas que le bucket soit supprimé
resource "google_storage_bucket" "bucket-auto-expire-handled" {
  name          = "bkt-${var.project_id}-handled"
  project       = var.project_id
  location      = var.region
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 15
    }
    action {
      type = "Delete"
    }
  }
}

# # Pour creeer plusieurs buckets en une fois
# module "gcs_buckets" {
#   source  = "terraform-google-modules/cloud-storage/google"
#   version = "~> 2.2"
#   project_id  = "${var.project_id}"
#   names = ["in", "handled"]
#   prefix = "bkt-${var.project_id}"
#   set_admin_roles = true
#   admins = ["group:foo-admins@example.com"]
#   versioning = {
#     first = true
#   }
#   bucket_admins = {
#     second = "user:spam@example.com,eggs@example.com"
#   }
# }



# creation d'un objet dans le bucket
resource "google_storage_bucket_object" "archive" {
  name   = "archive/"
  # source = "../../../README.md"
  bucket = google_storage_bucket.bucket-auto-expire-handled.name
  content = "README.md"
}

# creation d'un objet dans le bucket
resource "google_storage_bucket_object" "rejet" {
  name   = "rejet/"
  bucket = google_storage_bucket.bucket-auto-expire-handled.name
  content = "rejet.txt"
}

# creation d'un objet dans le bucket
resource "google_storage_bucket_object" "in" {
  name   = "in/"
  bucket = google_storage_bucket.bucket-auto-expire-handled.name
  content = "in.txt"
}

# creation d'un objet dans le bucket
resource "google_storage_bucket_object" "output" {
  name   = "output/"
  bucket = google_storage_bucket.bucket-auto-expire-handled.name
  content = "output.txt"
}