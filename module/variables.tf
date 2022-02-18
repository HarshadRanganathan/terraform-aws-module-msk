variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name, e.g. 'eg' or 'cp'"
  default     = ""
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
  default     = ""
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'cluster'"
  default     = ""
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "enabled" {
  type        = bool
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = true
}

variable "kafka_version" {
  description = "specify the kafka version one verison is 2.1.0"
  type = string
  default = ""
}

variable "number_of_broker_nodes" {
  description = "set the number of kafka broker nodes"
  type = string
  default = ""
}

variable "instance_type" {
  description = "set the aws instance type for the broker nodes default kafka.m5.large other options see https://aws.amazon.com/msk/pricing/"
  type = string
  default = "kafka.m5.large"
}

variable "ebs_volume_size" {
  description = "set the ebs volume size for the msk broker nodes"
  type = string
  default = "1000"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "msk_tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "VPC ID for where the MSK nodes will reside"
  type        = string
}

variable "client_subnets" {
  description = "A list of subnets to connect to in client VPC"
  type        = list(string)
  default     = []
}

variable "encryption_at_rest_kms_key_arn" {
  description = "You may specify a KMS key short ID or ARN"
  type        = string
  default     = ""
}

variable "client_broker" {
  description = "Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT."
  type        = string
  default     = "TLS_PLAINTEXT"
}

variable "az_distribution" {
  description = "The distribution of broker nodes across availability zones"
  type        = string
  default     = "DEFAULT"
}

variable "config_name" {
  description = "Naem of the configuration"
  type        = string
  default     = ""
}

variable "server_properties" {
  description = "Contents of the server.properties file"
}

variable "config_description" {
  description = "Description of the configuration."
  type        = string
  default     = ""
}

variable "config_enabled" {
  description = "Enable server configuration"
  type        = bool
  default     = false
}

variable "enhanced_monitoring" {
  description = "Specify the desired enhanced MSK CloudWatch monitoring level."
  type        = string
  default     = "DEFAULT"
}

variable "jmx_exporter_enabled" {
  description = "Indicates whether you want to enable or disable the JMX Exporter"
  type        = bool
  default     = false
}

variable "node_exporter_enabled" {
  description = "Indicates whether you want to enable or disavle the NODE Exporter"
  type        = bool
  default     = false
}

variable "enable_cloudwatch_logs" {
  description = "Indicates wheterh you want to enable or disable streaming broker logs to Cloudwatch Logs"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_arn" {
  description = "Name of the Cloudwatch Log Group to deliver logs to"
  type        = string
  default     = ""
}

variable "cidr_blocks" {
  type        = list(string)
  default     = []
  description = "Cidr blocks (e.g. `10.0.0.0/16`)"
}
