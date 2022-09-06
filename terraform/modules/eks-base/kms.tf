resource "aws_kms_key" "eks" {
  deletion_window_in_days = 14
  enable_key_rotation     = true
  description             = "${var.cluster_name} EKS encryption key"

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_kms_alias" "eks" {
  name          = "alias/${var.cluster_name}-eks"
  target_key_id = aws_kms_key.eks.key_id
}

resource "aws_kms_key" "fluxcd" {
  deletion_window_in_days = 14
  enable_key_rotation     = true
  description             = "fluxcd EKS encryption key"

  tags = merge(var.tags, {
    "karpenter.sh/discovery" = var.cluster_name
  })
}

resource "aws_kms_alias" "fluxcd" {
  name          = "alias/${var.cluster_name}-fluxcd"
  target_key_id = aws_kms_key.fluxcd.key_id
}
