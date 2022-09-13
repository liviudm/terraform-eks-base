locals {
  cluster_version = "1.23"
  cluster_addons_version = {
    "coredns"            = "v1.8.7-eksbuild.2",
    "kube-proxy"         = "v1.23.7-eksbuild.1",
    "aws-ebs-csi-driver" = "v1.11.2-eksbuild.1",
    "vpc-cni"            = "v1.11.3-eksbuild.1",
    "karpenter"          = "0.16.0"
  }
  github_known_hosts = "github.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg="
}
