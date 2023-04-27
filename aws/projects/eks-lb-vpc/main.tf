provider "aws" {
  region = var.region
}

module "eks-vpc" {
  source       = "../../modules/vpc/"
  project_name = var.project_name

  # The CIDR block for the VPC. This provides a range of IP addresses that can be used for resources in the VPC.
  # A /21 CIDR block provides up to 2,048 IP addresses, which should be sufficient for the stated requirements.
  cidr = "10.0.0.0/21"

  # 1,020 usable IP addresses for instances in the private subnets (510 per subnet x 2 subnets)
  private_subnets = ["10.0.0.0/23", "10.0.2.0/23"]
  # 1,020 usable IP addresses for instances in the public subnets (510 per subnet x 2 subnets)
  public_subnets = ["10.0.4.0/23", "10.0.6.0/23"]

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}

module "eks-project-eks" {
  source          = "../../modules/eks/"
  cluster_name    = "${var.project_name}-eks"
  cluster_version = "1.26"
  vpc_id          = module.eks-vpc.vpc_id
  public_subnets  = module.eks-vpc.public_subnets
  private_subnets = module.eks-vpc.private_subnets
  region          = var.region

  eks_managed_node_groups = {
    private = {
      name           = "private-nodegroup"
      instance_types = ["t3.small"]
      min_size       = 1
      max_size       = 3
      desired_size   = 1
      subnet_ids     = module.eks-vpc.private_subnets
    }
  }

  tags = {
    Environment = "dev"
    Project     = var.project_name
  }
}