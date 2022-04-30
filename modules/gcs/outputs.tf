output "bucket_in" {
  value = "${google_storage_bucket.bucket-auto-expire-in.name}"
}

output "bucket_handled" {
  value = "${google_storage_bucket.bucket-auto-expire-handled.name}"
}
