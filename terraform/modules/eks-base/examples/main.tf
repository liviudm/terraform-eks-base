#---------------------------------------------------------------
# Provider configuration
#---------------------------------------------------------------
terraform {
  required_version = "~> 1.0"

  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.14"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    }
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
    }
  }
}

provider "kubectl" {
  apply_retry_count      = 5
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  load_config_file       = false

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_id]
  }
}

#---------------------------------------------------------------
# Data resources
#---------------------------------------------------------------
data "aws_eks_cluster" "default" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}

#---------------------------------------------------------------
# EKS Cluster
#---------------------------------------------------------------
module "eks_base" {
  source = "../"

  cluster_admins = ["arn:aws:iam::555508912583:user/liviu.damian@digitalmob.ro"]
  cluster_name = "kube-test-liviudm-com"
  github_token = var.github_token
  network = "10.100.0.0/16"
  tags = {
    Project = "liviudm"
    Environment = "mixed"
  }
}

#---------------------------------------------------------------
# Variables
#---------------------------------------------------------------
variable "github_token" {}
