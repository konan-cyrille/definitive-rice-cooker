
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




# output "network" {
#   value = "${module.vpc.network}"
# }

# output "subnet" {
#   value = "${module.vpc.subnet}"
# }

# output "firewall_rule" {
#   value = "${module.firewall.firewall_rule}"
# }

# output "instance_name" {
#   value = "${module.http_server.instance_name}"
# }

# output "external_ip" {
#   value = "${module.http_server.external_ip}"
# }
