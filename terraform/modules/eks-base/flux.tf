module "irsa_flux" {
  source  = "registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.3.1"

  role_name = "${var.cluster_name}-flux"

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["flux-system:kustomize-controller"]
    }
  }

  role_policy_arns = {
    github_actions_runner = aws_iam_policy.flux.arn

  }

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_iam_policy" "flux" {
  name        = "${var.cluster_name}-flux"
  description = "Used for Flux Kustomize Controller"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Effect   = "Allow"
        Resource = aws_kms_key.fluxcd.arn
      },
    ]

  })

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

data "flux_install" "main" {
  target_path      = "k8s/clusters/${var.cluster_name}"
  components_extra = ["image-reflector-controller", "image-automation-controller"]
}

data "flux_sync" "main" {
  target_path = "k8s/clusters/${var.cluster_name}"
  url         = "ssh://git@github.com/${var.github_owner}/${var.flux_repository_name}.git"
  branch      = var.flux_branch
  patch_names = keys(local.patches)
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }

  lifecycle {
    ignore_changes = [
      metadata[0].labels,
    ]
  }
}

data "kubectl_file_documents" "install" {
  content = data.flux_install.main.content
}

data "kubectl_file_documents" "sync" {
  content = data.flux_sync.main.content
}

locals {
  install = [
    for v in data.kubectl_file_documents.install.documents : {
      data : yamldecode(v)
      content : v
    }
  ]
  sync = [
    for v in data.kubectl_file_documents.sync.documents : {
      data : yamldecode(v)
      content : v
    }
  ]
  # Patch flux service account with iam role annotations
  patches = {
    psa_kustomize = <<EOT
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    annotations:
      eks.amazonaws.com/role-arn: ${module.irsa_flux.iam_role_arn}
    name: kustomize-controller
    namespace: flux-system
    EOT

    psa_helm = <<EOT
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    annotations:
      eks.amazonaws.com/role-arn: ${module.irsa_flux.iam_role_arn}
    name: helm-controller
    namespace: flux-system
    EOT

    psa_source = <<EOT
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    annotations:
      eks.amazonaws.com/role-arn: ${module.irsa_flux.iam_role_arn}
    name: source-controller
    namespace: flux-system
    EOT

    psa_notification = <<EOT
  apiVersion: v1
  kind: ServiceAccount
  metadata:
    annotations:
      eks.amazonaws.com/role-arn: ${module.irsa_flux.iam_role_arn}
    name: notification-controller
    namespace: flux-system
    EOT
  }
}

resource "kubectl_manifest" "install" {
  for_each = {
    for v in local.install : lower(join("/", compact([
      v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name
    ]))) => v.content
  }
  depends_on = [kubernetes_namespace.flux_system, kubectl_manifest.karpenter_provisioner]
  yaml_body  = each.value
}

resource "kubectl_manifest" "sync" {
  for_each = {
    for v in local.sync : lower(join("/", compact([
      v.data.apiVersion, v.data.kind, lookup(v.data.metadata, "namespace", ""), v.data.metadata.name
    ]))) => v.content
  }
  depends_on = [kubernetes_namespace.flux_system, kubectl_manifest.karpenter_provisioner]
  yaml_body  = each.value
}

resource "kubernetes_secret" "main" {
  depends_on = [kubectl_manifest.install]

  metadata {
    name      = data.flux_sync.main.secret
    namespace = data.flux_sync.main.namespace
  }

  data = {
    identity       = tls_private_key.flux.private_key_pem
    "identity.pub" = tls_private_key.flux.public_key_pem
    known_hosts    = local.github_known_hosts
  }
}

data "github_repository" "main" {
  full_name = format("%s/%s", var.github_owner, var.flux_repository_name)
}

resource "github_repository_deploy_key" "main" {
  title      = "flux-${var.cluster_name}"
  repository = data.github_repository.main.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = true
}

resource "github_repository_file" "install" {
  repository = data.github_repository.main.name
  file       = data.flux_install.main.path
  content    = data.flux_install.main.content
  branch     = var.flux_branch
}

resource "github_repository_file" "sync" {
  repository = data.github_repository.main.name
  file       = data.flux_sync.main.path
  content    = data.flux_sync.main.content
  branch     = var.flux_branch
}


resource "github_repository_file" "patches" {
  for_each   = data.flux_sync.main.patch_file_paths
  repository = data.github_repository.main.name
  file       = each.value
  content    = local.patches[each.key]
  branch     = var.flux_branch
}

resource "github_repository_file" "kustomize" {
  repository = data.github_repository.main.name
  file       = data.flux_sync.main.kustomize_path
  content    = data.flux_sync.main.kustomize_content
  branch     = var.flux_branch
}
