module "eks" {
  source  = "registry.terraform.io/terraform-aws-modules/eks/aws"
  version = "18.29.0"

  cluster_name    = var.cluster_name
  cluster_version = local.cluster_version

  cluster_addons = {
    coredns = {
      addon_version     = local.cluster_addons_version.coredns
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {
      addon_version     = local.cluster_addons_version.kube-proxy
      resolve_conflicts = "OVERWRITE"
    }
  }

  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.eks.arn
      resources        = ["secrets"]
    }
  ]

  cluster_ip_family               = "ipv4"
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access_cidrs = [
    "0.0.0.0/0"
  ]

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa                   = true
  create_cluster_security_group = false
  create_node_security_group    = false

  #  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true
  aws_auth_users            = [
    for user_arn in concat(var.cluster_admins) : {
      userarn  = user_arn
      username = split("/", user_arn)[1]
      groups   = ["system:masters"]
    }
  ]

  create_cloudwatch_log_group            = true
  cloudwatch_log_group_retention_in_days = 30
  cluster_enabled_log_types              = var.cluster_enabled_log_types

  node_security_group_additional_rules = {
    ingress_nodes_karpenter_port = {
      description                   = "Cluster API to Node group for Karpenter webhook"
      protocol                      = "tcp"
      from_port                     = 8443
      to_port                       = 8443
      type                          = "ingress"
      source_cluster_security_group = true
    }
  }

  eks_managed_node_groups = {
    karpenter = {
      instance_types                        = ["t3a.medium"]
      create_security_group                 = false
      attach_cluster_primary_security_group = true

      min_size     = 1
      max_size     = 1
      desired_size = 1

      iam_role_attach_cni_policy = true
      iam_role_additional_policies = [
        "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
      ]

      taints = [
        {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      ]
    }
  }

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_eks_addon" "ebs_csi" {
  cluster_name = module.eks.cluster_id
  addon_name   = "aws-ebs-csi-driver"

  addon_version            = local.cluster_addons_version.aws-ebs-csi-driver
  resolve_conflicts        = "OVERWRITE"
  service_account_role_arn = module.irsa_ebs_csi.iam_role_arn

  depends_on = [
    module.eks.eks_managed_node_groups,
  ]

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = module.eks.cluster_id
  addon_name   = "vpc-cni"

  addon_version            = local.cluster_addons_version.vpc-cni
  resolve_conflicts        = "OVERWRITE"
  service_account_role_arn = module.irsa_vpc_cni.iam_role_arn

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}
