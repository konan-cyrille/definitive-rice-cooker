output "bucket_in" {
  value = "${module.gcs.bucket_in}"
}

output "bucket_handled" {
  value = "${module.gcs.bucket_handled}"
}

output "dataset_raw" {
  value = "${module.bigquery.dataset_raw}"
}


output "dataset_prepared" {
  value = "${module.bigquery.dataset_prepared}"
}

