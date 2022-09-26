module "irsa_karpenter" {
  source  = "registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.4.0"

  role_name                          = "${var.cluster_name}-karpenter-controller"
  attach_karpenter_controller_policy = true

  karpenter_controller_cluster_id = module.eks.cluster_id
  karpenter_controller_ssm_parameter_arns = [
    "arn:aws:ssm:*:*:parameter/aws/service/*"
  ]
  karpenter_controller_node_iam_role_arns = [
    module.eks.eks_managed_node_groups["karpenter"].iam_role_arn
  ]

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["karpenter:karpenter"]
    }
  }

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_iam_instance_profile" "karpenter" {
  name = "${var.cluster_name}-KarpenterNodeInstanceProfile"
  role = module.eks.eks_managed_node_groups["karpenter"].iam_role_name

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "helm_release" "karpenter" {
  namespace        = "karpenter"
  create_namespace = true

  name       = "karpenter"
  repository = "https://charts.karpenter.sh"
  chart      = "karpenter"
  version    = local.cluster_addons_version.karpenter

  set {
    name  = "replicas"
    value = "1"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.irsa_karpenter.iam_role_arn
  }

  set {
    name  = "clusterName"
    value = module.eks.cluster_id
  }

  set {
    name  = "clusterEndpoint"
    value = module.eks.cluster_endpoint
  }

  set {
    name  = "aws.defaultInstanceProfile"
    value = aws_iam_instance_profile.karpenter.name
  }
}

resource "kubectl_manifest" "karpenter_default_provisioner" {
  yaml_body = <<-YAML
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: default
  spec:
    consolitation:
      enabled: true
    labels:
      k8s-workload: dev
    requirements:
      - key: node.kubernetes.io/instance-type
        operator: In
        values: ${jsonencode(var.default_instance_types)}
      - key: kubernetes.io/arch
        operator: In
        values: ${jsonencode(var.node_instance_arch)}
      - key: karpenter.sh/capacity-type
        operator: In
        values: ${jsonencode(var.node_instance_capacity_types)}
    providerRef:
      name: default
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

resource "kubectl_manifest" "karpenter_production_provisioner" {
  yaml_body = <<-YAML
  apiVersion: karpenter.sh/v1alpha5
  kind: Provisioner
  metadata:
    name: production
  spec:
    consolitation:
      enabled: true
    taints:
      - key: digitalmob.ro/production
        effect: NoSchedule
    labels:
      k8s-workload: production
    requirements:
      - key: node.kubernetes.io/instance-type
        operator: In
        values: ${jsonencode(var.production_instance_types)}
      - key: kubernetes.io/arch
        operator: In
        values: ${jsonencode(var.node_instance_arch)}
      - key: karpenter.sh/capacity-type
        operator: In
        values: ["on-demand"]
    providerRef:
      name: default
  YAML

  depends_on = [
    helm_release.karpenter
  ]
}

resource "kubectl_manifest" "karpenter_awsnodetemplate" {
  yaml_body = <<-YAML
  apiVersion: karpenter.k8s.aws/v1alpha1
  kind: AWSNodeTemplate
  metadata:
    name: default
  spec:
    amiFamily: AL2
    instanceProfile: ${aws_iam_instance_profile.karpenter.name}
    blockDeviceMappings:
      - deviceName: /dev/xvda
        ebs:
          volumeSize: 50Gi
          volumeType: gp3
          iops: 3000
          throughput: 125
          deleteOnTermination: true
    subnetSelector:
      karpenter.sh/discovery: ${var.cluster_name}
    securityGroupSelector:
      karpenter.sh/discovery: ${var.cluster_name}
    tags:
      karpenter.sh/discovery: ${var.cluster_name}
  YAML

  depends_on = [helm_release.karpenter]
}

data "http" "karpenter_provisioner_crd" {
  url = "https://raw.githubusercontent.com/aws/karpenter/v${local.cluster_addons_version.karpenter}/charts/karpenter/crds/karpenter.sh_provisioners.yaml"
}

data "http" "karpenter_awsnodetemplates_crd" {
  url = "https://raw.githubusercontent.com/aws/karpenter/v${local.cluster_addons_version.karpenter}/charts/karpenter/crds/karpenter.k8s.aws_awsnodetemplates.yaml"
}

resource "kubectl_manifest" "karpenter_provisioner_crd" {
  yaml_body = data.http.karpenter_provisioner_crd.response_body

  depends_on = [helm_release.karpenter]
}

resource "kubectl_manifest" "karpenter_awsnodetemplates_crd" {
  yaml_body = data.http.karpenter_awsnodetemplates_crd.response_body

  depends_on = [helm_release.karpenter]
}
