## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | 0.18.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.31 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.5.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | = 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.13 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_flux"></a> [flux](#provider\_flux) | 0.18.0 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 4.31 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.5.1 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | = 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.13 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | registry.terraform.io/terraform-aws-modules/eks/aws | 18.29.0 |
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | registry.terraform.io/terraform-aws-modules/vpc/aws//modules/vpc-endpoints | 3.14.2 |
| <a name="module_irsa_ebs_csi"></a> [irsa\_ebs\_csi](#module\_irsa\_ebs\_csi) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.3.1 |
| <a name="module_irsa_external_dns"></a> [irsa\_external\_dns](#module\_irsa\_external\_dns) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.3.1 |
| <a name="module_irsa_flux"></a> [irsa\_flux](#module\_irsa\_flux) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.3.1 |
| <a name="module_irsa_github_actions_runner"></a> [irsa\_github\_actions\_runner](#module\_irsa\_github\_actions\_runner) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.3.1 |
| <a name="module_irsa_karpenter"></a> [irsa\_karpenter](#module\_irsa\_karpenter) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.3.1 |
| <a name="module_irsa_vpc_cni"></a> [irsa\_vpc\_cni](#module\_irsa\_vpc\_cni) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.3.1 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | registry.terraform.io/terraform-aws-modules/vpc/aws | 3.14.2 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_instance_profile.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.flux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.github_actions_runner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.fluxcd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.fluxcd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.vpc_endpoints_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [github_repository_deploy_key.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_file.install](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.kustomize](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.patches](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.sync](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [kubectl_manifest.install](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_awsnodetemplate](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_awsnodetemplates_crd](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_production_provisioner](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_provisioner](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_provisioner_crd](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.github_actions_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.github_actions_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [tls_private_key.flux](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [flux_install.main](https://registry.terraform.io/providers/fluxcd/flux/0.18.0/docs/data-sources/install) | data source |
| [flux_sync.main](https://registry.terraform.io/providers/fluxcd/flux/0.18.0/docs/data-sources/sync) | data source |
| [github_repository.main](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [http_http.karpenter_awsnodetemplates_crd](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.karpenter_provisioner_crd](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.install](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_admins"></a> [cluster\_admins](#input\_cluster\_admins) | List of EKS Cluster administrators | `list(string)` | n/a | yes |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | List of Cloudwatch EKS Control Plane log types to enable | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS Cluster Name | `string` | n/a | yes |
| <a name="input_default_instance_types"></a> [default\_instance\_types](#input\_default\_instance\_types) | Karpenter Provisioner EC2 instance types | `list(string)` | <pre>[<br>  "t3a.small",<br>  "t3a.medium",<br>  "m6a.large",<br>  "m6a.xlarge",<br>  "m6a.2xlarge",<br>  "m6a.4xlarge",<br>  "c6a.large",<br>  "c6a.xlarge",<br>  "c6a.2xlarge",<br>  "c6a.4xlarge",<br>  "r6a.large",<br>  "r6a.xlarge",<br>  "r6a.2xlarge",<br>  "r6a.4xlarge"<br>]</pre> | no |
| <a name="input_flux_branch"></a> [flux\_branch](#input\_flux\_branch) | branch name | `string` | `"master"` | no |
| <a name="input_flux_repository_name"></a> [flux\_repository\_name](#input\_flux\_repository\_name) | Flux github repository name | `string` | `"infrastructure"` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | Flux github owner | `string` | `"DigitalMOB2"` | no |
| <a name="input_network"></a> [network](#input\_network) | Network CIDR to be used for VPC | `string` | n/a | yes |
| <a name="input_node_instance_arch"></a> [node\_instance\_arch](#input\_node\_instance\_arch) | Karpenter Provisioner EC2 instance architecture | `list(string)` | <pre>[<br>  "amd64"<br>]</pre> | no |
| <a name="input_node_instance_capacity_types"></a> [node\_instance\_capacity\_types](#input\_node\_instance\_capacity\_types) | Karpenter Provisioner EC2 instance capacity type | `list(string)` | <pre>[<br>  "spot",<br>  "on-demand"<br>]</pre> | no |
| <a name="input_production_instance_types"></a> [production\_instance\_types](#input\_production\_instance\_types) | Karpenter Production Provisioner EC2 instance types | `list(string)` | <pre>[<br>  "m6a.large",<br>  "m6a.xlarge",<br>  "m6a.2xlarge",<br>  "m6a.4xlarge",<br>  "c6a.large",<br>  "c6a.xlarge",<br>  "c6a.2xlarge",<br>  "c6a.4xlarge",<br>  "r6a.large",<br>  "r6a.xlarge",<br>  "r6a.2xlarge",<br>  "r6a.4xlarge"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags for all resources | `map(string)` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Do NOT use. Added just to provide compatibility for misc EKS cluster | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_database_subnets_group_name"></a> [database\_subnets\_group\_name](#output\_database\_subnets\_group\_name) | n/a |
| <a name="output_eks_security_group_id"></a> [eks\_security\_group\_id](#output\_eks\_security\_group\_id) | n/a |
| <a name="output_flux_kms"></a> [flux\_kms](#output\_flux\_kms) | n/a |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_flux"></a> [flux](#requirement\_flux) | 0.18.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 4.31 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.5.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | = 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.13 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.0 |
| <a name="provider_flux"></a> [flux](#provider\_flux) | 0.18.0 |
| <a name="provider_github"></a> [github](#provider\_github) | ~> 4.31 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.5.1 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | = 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.13 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | registry.terraform.io/terraform-aws-modules/eks/aws | 18.29.1 |
| <a name="module_endpoints"></a> [endpoints](#module\_endpoints) | registry.terraform.io/terraform-aws-modules/vpc/aws//modules/vpc-endpoints | 3.16.0 |
| <a name="module_irsa_ebs_csi"></a> [irsa\_ebs\_csi](#module\_irsa\_ebs\_csi) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.5.0 |
| <a name="module_irsa_external_dns"></a> [irsa\_external\_dns](#module\_irsa\_external\_dns) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.5.0 |
| <a name="module_irsa_flux"></a> [irsa\_flux](#module\_irsa\_flux) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.5.0 |
| <a name="module_irsa_github_actions_runner"></a> [irsa\_github\_actions\_runner](#module\_irsa\_github\_actions\_runner) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.5.0 |
| <a name="module_irsa_karpenter"></a> [irsa\_karpenter](#module\_irsa\_karpenter) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.5.0 |
| <a name="module_irsa_vpc_cni"></a> [irsa\_vpc\_cni](#module\_irsa\_vpc\_cni) | registry.terraform.io/terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks | 5.5.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | registry.terraform.io/terraform-aws-modules/vpc/aws | 3.16.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_addon.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_iam_instance_profile.karpenter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.flux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.github_actions_runner](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_kms_alias.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.fluxcd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.fluxcd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.vpc_endpoints_https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [github_repository_deploy_key.main](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_deploy_key) | resource |
| [github_repository_file.install](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.kustomize](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.patches](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [github_repository_file.sync](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file) | resource |
| [helm_release.karpenter](https://registry.terraform.io/providers/hashicorp/helm/2.5.1/docs/resources/release) | resource |
| [kubectl_manifest.install](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_awsnodetemplate](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_awsnodetemplates_crd](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_default_provisioner](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_production_provisioner](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.karpenter_provisioner_crd](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubectl_manifest.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/resources/manifest) | resource |
| [kubernetes_namespace.flux_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.github_actions_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_secret.main](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [kubernetes_service_account.external_dns](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_service_account.github_actions_runner](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [tls_private_key.flux](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_security_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/security_group) | data source |
| [flux_install.main](https://registry.terraform.io/providers/fluxcd/flux/0.18.0/docs/data-sources/install) | data source |
| [flux_sync.main](https://registry.terraform.io/providers/fluxcd/flux/0.18.0/docs/data-sources/sync) | data source |
| [github_repository.main](https://registry.terraform.io/providers/integrations/github/latest/docs/data-sources/repository) | data source |
| [http_http.karpenter_awsnodetemplates_crd](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.karpenter_provisioner_crd](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [kubectl_file_documents.install](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/data-sources/file_documents) | data source |
| [kubectl_file_documents.sync](https://registry.terraform.io/providers/gavinbunney/kubectl/1.14.0/docs/data-sources/file_documents) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_admins"></a> [cluster\_admins](#input\_cluster\_admins) | List of EKS Cluster administrators | `list(string)` | n/a | yes |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | List of Cloudwatch EKS Control Plane log types to enable | `list(string)` | <pre>[<br>  "api",<br>  "audit",<br>  "authenticator",<br>  "controllerManager",<br>  "scheduler"<br>]</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | EKS Cluster Name | `string` | n/a | yes |
| <a name="input_default_instance_types"></a> [default\_instance\_types](#input\_default\_instance\_types) | Karpenter Provisioner EC2 instance types | `list(string)` | <pre>[<br>  "t3a.small",<br>  "t3a.medium",<br>  "m6a.large",<br>  "m6a.xlarge",<br>  "m6a.2xlarge",<br>  "m6a.4xlarge",<br>  "c6a.large",<br>  "c6a.xlarge",<br>  "c6a.2xlarge",<br>  "c6a.4xlarge",<br>  "r6a.large",<br>  "r6a.xlarge",<br>  "r6a.2xlarge",<br>  "r6a.4xlarge"<br>]</pre> | no |
| <a name="input_flux_branch"></a> [flux\_branch](#input\_flux\_branch) | branch name | `string` | `"master"` | no |
| <a name="input_flux_repository_name"></a> [flux\_repository\_name](#input\_flux\_repository\_name) | Flux github repository name | `string` | `"infrastructure"` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | Flux github owner | `string` | `"DigitalMOB2"` | no |
| <a name="input_network"></a> [network](#input\_network) | Network CIDR to be used for VPC | `string` | n/a | yes |
| <a name="input_node_instance_arch"></a> [node\_instance\_arch](#input\_node\_instance\_arch) | Karpenter Provisioner EC2 instance architecture | `list(string)` | <pre>[<br>  "amd64"<br>]</pre> | no |
| <a name="input_node_instance_capacity_types"></a> [node\_instance\_capacity\_types](#input\_node\_instance\_capacity\_types) | Karpenter Provisioner EC2 instance capacity type | `list(string)` | <pre>[<br>  "spot",<br>  "on-demand"<br>]</pre> | no |
| <a name="input_production_instance_types"></a> [production\_instance\_types](#input\_production\_instance\_types) | Karpenter Production Provisioner EC2 instance types | `list(string)` | <pre>[<br>  "m6a.large",<br>  "m6a.xlarge",<br>  "m6a.2xlarge",<br>  "m6a.4xlarge",<br>  "c6a.large",<br>  "c6a.xlarge",<br>  "c6a.2xlarge",<br>  "c6a.4xlarge",<br>  "r6a.large",<br>  "r6a.xlarge",<br>  "r6a.2xlarge",<br>  "r6a.4xlarge"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags for all resources | `map(string)` | n/a | yes |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Do NOT use. Added just to provide compatibility for misc EKS cluster | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | n/a |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | n/a |
| <a name="output_database_subnets_group_name"></a> [database\_subnets\_group\_name](#output\_database\_subnets\_group\_name) | n/a |
| <a name="output_eks_security_group_id"></a> [eks\_security\_group\_id](#output\_eks\_security\_group\_id) | n/a |
| <a name="output_flux_kms"></a> [flux\_kms](#output\_flux\_kms) | n/a |
<!-- END_TF_DOCS -->