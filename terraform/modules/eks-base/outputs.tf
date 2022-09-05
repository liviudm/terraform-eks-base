output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "database_subnets_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "eks_security_group_id" {
  value = module.eks.cluster_primary_security_group_id
}

output "flux_kms" {
  value = aws_kms_key.fluxcd.arn
}
