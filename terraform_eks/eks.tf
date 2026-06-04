module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = local.name
  kubernetes_version = "1.33"
  endpoint_public_access = true
  
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  
#   control_plane_subnet_ids
  control_plane_subnet_ids = module.vpc.intra_subnets

  # managing node in the cluster
  eks_managed_node_groups = {
    tws-cluster-ng = {
      instance_types = ["t2.medium"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
      capactity_type = "SPOT"
    }
  

   cluster_addons = {
    vpc-cni = {
        most_recent = true
    }
    kube-proxy = {
        most_recent = true
    }
    coredns = {
        most_recent = true
    }               
   }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"
  }
}
