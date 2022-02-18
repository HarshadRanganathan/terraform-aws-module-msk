# terraform-aws-module-msk

Terraform module to create an MSK cluster in AWS default is to use 3 AZs.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| broker_node_group_info | Configuration block for the broker nodes of the Kafka cluster. | config_block | - | yes |
| cluster_name | Name of the MSK cluster. | string | `` | yes |
| kafka_version | Specify the desired Kafka software version.| string | `` | yes |
| number_of_broker_nodes | The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets. | bool | `` | yes |
| client_authentication | Configuration block for specifying a client authentication. See below.| string | `` | no |
| configuration_info | Configuration block for specifying a MSK Configuration to attach to Kafka brokers. See below. | string | `` | no |
| encryption_info | Configuration block for specifying encryption. See below. | string | `` | no |
| enhanced_monitoring | Specify the desired enhanced MSK CloudWatch monitoring level | string | `` | no |
| open_monitoring | Configuration block for JMX and Node monitoring for the MSK cluster. See below. | string | `` | no |
| logging_info | Configuration block for streaming broker logs to Cloudwatch/S3/Kinesis Firehose | config_block | `` | no |
| tags | A map of tags to assign to the resource | map(string) | '{}' | no |


### broker_node_group_info
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| client_subnets | A list of subnets to connect to in client VPC | list | '[]' | yes |
| ebs_volume_size | The size in GiB of the EBS volume for the data drive on each broker node. | number | '' | yes |
| instance_type | Specify the instance type to use for the kafka brokers. e.g. kafka.m5.large | string | '' | yes |
| security_groups | A list of the security groups to associate with the elastic network interfaces to control who can communicate with the cluster. | list | '' | yes |
| az_distribution | The distribution of broker nodes across availability zones | string | '' | no |

### client_authentication
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| tls | Configuration block for specifying TLS client authentication. See below. | '' | '' | no |

### client_authentication_tls
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| certificate_authority_arns | List of ACM Certificate Authority Amazon Resource Names (ARNs). | list | '' | no |

### configuraiton_info
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| arn | Amazon Resource Name (ARN) of the MSK Configuration to use in the cluster. | string | '' | yes |
| revision | Revision of the MSK Configuration to use in the cluster. | string | '' | yes |

### encryption_info
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| encryption_in_transit | Configuration block to specify encryption in transit. | block | '' | no |
| encryption_at_rest_kms_key_arn | You may specify a KMS key short ID or ARN (it will always output an ARN) to use for encrypting your data at rest. If no key is specified, an AWS managed KMS ('aws/msk' managed service) key will be used for encrypting the data at rest. | string | ''| no |

#### encryption_in_transit {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| client_broker | Encryption setting for data in transit between clients and brokers. Valid values: TLS, TLS_PLAINTEXT, and PLAINTEXT | string | TLS | no |
| in_cluster | Whether data communication among broker nodes is encrypted | bool | true | no |

### open_monitoring
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| prometheus | Configuration block for Prometheus settings for open monitoring see block | block | '' | yes |

#### open_monitoring_prometheus {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| jmx_exporter | Configuration block for JMX Exporter | block | '' | '' | no |
| node_exporter | Configuration block for Node Exporter | block | '' | '' | no |

#### open_monitoring_prometheus_jmx_exporter {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled_in_broker | Indicates whether you want to enable or disable the JMX Exporter | bool | '' | yes |

#### open_monitoring_prometheus_node_exporter {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled_in_broker | Indicates whether you want to enable or disable the JMX Exporter | bool | '' | yes |

### logging_info
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| broker_logs | Configuration block for Broker Logs settings for logging info. See below. | block | '' | yes |

### logging_info_cloudwatch_logs {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled | Indicates whether you want to enable or disable streaming broker logs to Cloudwatch Logs. | bool | '' | no |
| log_group | Name of the Cloudwatch Log Group to deliver logs to. | string | '' | no |

### logging_info_firehose_logs {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled | Indicates whether you want to enable or disable streaming broker logs to Kinesis Data Firehose. | bool | '' | no |
| delivery_stream | Name of the Kinesis Data Firehose delivery stream to deliver logs to. | string | '' | no |

### logging_info_s3_logs {block}
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled | Name of the S3 bucket to deliver logs to. | bool | '' | no |
| bucket | Name of the Kinesis Data Firehose delivery stream to deliver logs to. | string | '' | no |
| prefix | Prefix to append to the folder name. | string | '' | no |


## Outputs

| Name | Description |
|------|-------------|
| arn | Amazon Resource Name (ARN) of the MSK cluster. |
| bootstrap_brokers | A comma separated list of one or more hostname:port pairs of kafka brokers suitable to bootstrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set to PLAINTEXT or TLS_PLAINTEXT. |
| bootstrap_brokers_tls | A comma separated list of one or more DNS names (or IPs) and TLS port pairs kafka brokers suitable to bootstrap connectivity to the kafka cluster. Only contains value if client_broker encryption in transit is set to TLS_PLAINTEXT or TLS. |
| current_version | Current version of the MSK Cluster used for updates, e.g. K13V1IB3VIYZZH |
| encryption_info.0.encryption_at_rest_kms_key_arn | The ARN of the KMS key used for encryption at rest of the broker data volumes. | 
| zookeeper_connect_string | A comma separated list of one or more hostname:port pairs to use to connect to the Apache Zookeeper cluster. |

