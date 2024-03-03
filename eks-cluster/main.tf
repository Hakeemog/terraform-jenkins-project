# Create VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "EKS-vpc"
  cidr = var.vpc-cidr

  azs = data.aws_availability_zones.eks-terraform.names

  private_subnets      = var.private-subnet-cidr
  public_subnets       = var.subnet-cidr
  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }

}

# create EKS
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name    = "Haakeemog-eks-cluster"
  cluster_version = "1.24"

  #cluster_endpoint_public_access  = true



  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = var.private-subnet-cidr
  control_plane_subnet_ids = ["subnet-xyzde987", "subnet-slkjf456", "subnet-qeiru789"]

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = ["t2.small"]
    }
  }


  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}