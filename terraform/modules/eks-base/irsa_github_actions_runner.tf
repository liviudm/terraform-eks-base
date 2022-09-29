module "irsa_github_actions_runner" {
  source  = "registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.5.0"

  role_name = "${var.cluster_name}-github-actions-runner"

  oidc_providers = {
    eks = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["ops-actions-runner-controller:github-actions-runner"]
    }
  }

  role_policy_arns = {
    github_actions_runner = aws_iam_policy.github_actions_runner.arn

  }

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_iam_policy" "github_actions_runner" {
  name        = "${var.cluster_name}-github-actions-runner"
  description = "Used for running self hosted GitHub Actions runners"
  policy      = data.aws_iam_policy_document.github_actions_runner.json

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

#tfsec:ignore:aws-iam-no-policy-wildcards
data "aws_iam_policy_document" "github_actions_runner" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "kubernetes_namespace" "github_actions_runner" {
  metadata {
    name = "ops-actions-runner-controller"
    labels = {
      "kustomize.toolkit.fluxcd.io/name"      = "actions-runner-controller"
      "kustomize.toolkit.fluxcd.io/namespace" = "flux-system"
      "name"                                  = "ops-actions-runner-controller"
    }
  }
}

resource "kubernetes_service_account" "github_actions_runner" {
  metadata {
    name      = "github-actions-runner"
    namespace = kubernetes_namespace.github_actions_runner.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = module.irsa_github_actions_runner.iam_role_arn
    }
  }
}
