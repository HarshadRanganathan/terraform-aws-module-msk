
output "arn" {
  value = join("", aws_msk_cluster.main.*.arn)
}

output "zookeeper_connect_string" {
  value = join("", aws_msk_cluster.main.*.zookeeper_connect_string)
}

output "bootstrap_brokers" {
  description = "Plaintext connection host:port pairs"
  value       = join("", aws_msk_cluster.main.*.bootstrap_brokers)
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = join("", aws_msk_cluster.main.*.bootstrap_brokers_tls)
}

output "configuration_arn" {
  description = "TLS connection host:port pairs"
  value       = join("", aws_msk_configuration.main.*.arn)
}
