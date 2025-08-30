module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "${terraform.workspace}-${var.cluster_name}"
  kubernetes_version = var.cluster_version

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true
  enable_irsa                              = true
  authentication_mode                      = "API_AND_CONFIG_MAP"
  
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = var.eks_managed_node_groups

  tags = local.tags
}