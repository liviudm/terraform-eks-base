# There is a bug in the github provider which ignores the `owner` field:
# https://github.com/integrations/terraform-provider-github/issues/942
# https://github.com/integrations/terraform-provider-github/issues/1068
# https://github.com/integrations/terraform-provider-github/issues/667
#
# Apply with:
# GITHUB_OWNER=DigitalMOB2 GITHUB_TOKEN=token terraform plan -out tfplan
# GITHUB_OWNER=DigitalMOB2 GITHUB_TOKEN=token terraform apply tfplan
#
# Before destroying you have to run:
# kubectl delete provisioner default
# terraform state rm module.eks_base.kubernetes_namespace.flux_system
# terraform state rm module.eks_base.kubectl_manifest.karpenter_provisioner
#
#---------------------------------------------------------------
# Provider configuration
#---------------------------------------------------------------
terraform {
  required_version = "~> 1.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "= 1.14.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.31"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "github" {}

provider "kubernetes" {
  host                   = module.eks_base.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_base.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks_base.cluster_id]
  }
}

provider "helm" {
  kubernetes {
    host                   = module.eks_base.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks_base.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks_base.cluster_id]
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = module.eks_base.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_base.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks_base.cluster_id]
  }
}

#---------------------------------------------------------------
# Data resources
#---------------------------------------------------------------
data "aws_eks_cluster" "default" {
  name = module.eks_base.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks_base.cluster_id
}

#---------------------------------------------------------------
# EKS Cluster
#---------------------------------------------------------------
module "eks_base" {
  source = "../"

  cluster_admins = ["arn:aws:iam::555508912583:user/liviu.damian@digitalmob.ro"]
  cluster_name   = "kube-test-liviudm-com"
  network        = "10.100.0.0/16"
  tags = {
    Project     = "liviudm"
    Environment = "mixed"
  }
}
