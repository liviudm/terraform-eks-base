variable "network" {
  type        = string
  description = "Network CIDR to be used for VPC"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster Name"
}

variable "cluster_admins" {
  type        = list(string)
  description = "List of EKS Cluster administrators"
}

variable "cluster_enabled_log_types" {
  type        = list(string)
  description = "List of Cloudwatch EKS Control Plane log types to enable"
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "node_instance_type" {
  type        = list(string)
  description = "Karpenter Provisioner EC2 instance types "
  default     = ["m6a.large", "m6a.xlarge", "m6a.2xlarge", "m6a.4xlarge", "c6a.large", "c6a.xlarge", "c6a.2xlarge", "c6a.4xlarge", "r6a.large", "r6a.xlarge", "r6a.2xlarge", "r6a.4xlarge"]
}

variable "node_instance_arch" {
  type        = list(string)
  description = "Karpenter Provisioner EC2 instance architecture"
  default     = ["amd64"]
}

variable "node_instance_capacity_type" {
  type        = list(string)
  description = "Karpenter Provisioner EC2 instance capacity type"
  default     = ["spot", "on-demand"]
}

variable "tags" {
  type        = map(string)
  description = "Map of tags for all resources"
}

variable "github_owner" {
  type        = string
  description = "Flux github owner"
  default     = "DigitalMOB2"
}

variable "flux_repository_name" {
  type        = string
  description = "Flux github repository name"
  default     = "infrastructure"
}

variable "flux_branch" {
  type        = string
  description = "branch name"
  default     = "master"
}
