
module "label" {
  source     = "git::https://github.com/HarshadRanganathan/terraform-aws-module-null-label.git//module-v2?ref=1.0.0"
  namespace  = var.namespace
  stage      = var.stage
  name       = var.name
  delimiter  = var.delimiter
  tags       = var.tags
  enabled    = var.enabled
}

############
# Create a instance with random suffix.  This is needed to make sure that the instance name is unique
###########

resource "aws_security_group" "msk_security_group" {
  count       = var.enabled ? 1 : 0
  name_prefix = module.label.id
  vpc_id      = var.vpc_id

  # this is the incoming network traffic security rule
  ingress {
    description = "managed by terraform"
    from_port = 9094
    to_port   = 9094
    protocol  = "tcp"
    self      = true

    cidr_blocks = var.cidr_blocks
    # security_groups = [
    #aws_security_group.msk_security_group.id,
    #]
  }

  ingress {
    description = "managed by terraform"
    from_port = 11001
    to_port   = 11001
    protocol  = "tcp"
    self      = true

    cidr_blocks = var.cidr_blocks
    # security_groups = [
    #aws_security_group.msk_security_group.id,
    #]
  }

  ingress {
    description = "managed by terraform"
    from_port = 11002
    to_port   = 11002
    protocol  = "tcp"
    self      = true

    cidr_blocks = var.cidr_blocks
    # security_groups = [
    #aws_security_group.msk_security_group.id,
    #]
  }

  ingress {
    description = "managed by terraform"
    from_port = 2181
    to_port   = 2181
    protocol  = "tcp"
    self      = true

    cidr_blocks = var.cidr_blocks
    # security_groups = [
    #aws_security_group.msk_security_group.id,
    #]
  }

  ingress {
    description = "managed by terraform"
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    self      = true

    cidr_blocks = var.cidr_blocks
    # security_groups = [
    #aws_security_group.msk_security_group.id,
    #]
  }

  # this is the outgoing network traffic security rule
  egress {
    description = "managed by terraform"
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_msk_configuration" "main" {
  count          = var.config_enabled ? 1 : 0
  kafka_versions = [var.kafka_version]
  name           = "${module.label.id}-config"

  server_properties = var.server_properties
}

resource "aws_msk_cluster" "main" {
  count                  = var.enabled ? 1 : 0
  cluster_name           = module.label.id
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.instance_type
    ebs_volume_size = var.ebs_volume_size
    client_subnets  = var.client_subnets
    security_groups = [
      join("", aws_security_group.msk_security_group.*.id)
    ]
    az_distribution = var.az_distribution
  }

//  configuration_info {
//    arn      = aws_msk_configuration.main[count.index].arn
//    revision = aws_msk_configuration.main[count.index].latest_revision
//  }

  encryption_info {
    encryption_at_rest_kms_key_arn = var.encryption_at_rest_kms_key_arn

    encryption_in_transit {
      client_broker = var.client_broker
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = var.enable_cloudwatch_logs
        log_group = var.cloudwatch_log_group_arn
      }
    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = var.jmx_exporter_enabled
      }
      node_exporter {
        enabled_in_broker = var.node_exporter_enabled
      }
    }
  }

  enhanced_monitoring = var.enhanced_monitoring

  tags = var.msk_tags
}
