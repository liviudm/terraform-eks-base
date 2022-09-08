module "vpc" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws"
  version = "3.14.2"

  name = coalesce(var.vpc_name, var.cluster_name)
  cidr = var.network
  azs  = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]

  private_subnets = [
    cidrsubnet(var.network, 5, 0), cidrsubnet(var.network, 5, 1), cidrsubnet(var.network, 5, 2)
  ]
  public_subnets = [
    cidrsubnet(var.network, 3, 2), cidrsubnet(var.network, 3, 3), cidrsubnet(var.network, 3, 4)
  ]
  database_subnets = [
    cidrsubnet(var.network, 7, 12), cidrsubnet(var.network, 7, 13), cidrsubnet(var.network, 7, 14)
  ]
  elasticache_subnets = [
    cidrsubnet(var.network, 7, 15), cidrsubnet(var.network, 7, 16), cidrsubnet(var.network, 7, 17)
  ]
  redshift_subnets = [
    cidrsubnet(var.network, 8, 36), cidrsubnet(var.network, 8, 37), cidrsubnet(var.network, 8, 38)
  ]
  intra_subnets = [
    cidrsubnet(var.network, 8, 39), cidrsubnet(var.network, 8, 40), cidrsubnet(var.network, 8, 41)
  ]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_nat_gateway_route      = false
  create_database_internet_gateway_route = false

  create_elasticache_subnet_group       = true
  create_elasticache_subnet_route_table = true

  create_redshift_subnet_group       = true
  create_redshift_subnet_route_table = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                    = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"           = 1
    "karpenter.sh/discovery"                    = var.cluster_name
  }

  tags = var.tags
}

module "endpoints" {
  source  = "registry.terraform.io/terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "3.14.2"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [aws_security_group.vpc_endpoints_https.id]
  subnet_ids         = module.vpc.private_subnets

  endpoints = {
    s3 = {
      service = "s3"
    },
    kms = {
      service             = "kms"
      private_dns_enabled = true
    },
    ecr_dkr = {
      service             = "ecr.dkr"
      private_dns_enabled = true
    }
  }

  tags = var.tags
}

resource "aws_security_group" "vpc_endpoints_https" {
  name        = "VPC endpoints HTTPS"
  description = "Allow HTTPS traffic to VPC endpoints"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTPS access to local network"
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = [var.network]
  }

  egress {
    description = "Allow all egress traffic"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
