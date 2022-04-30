output "dataset_raw" {
  value = "${google_bigquery_dataset.dataset_raw.dataset_id}"
}

output "dataset_prepared" {
  value = "${google_bigquery_dataset.dataset_prepared.dataset_id}"
}
