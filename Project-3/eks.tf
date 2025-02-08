module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-cluster"
  cluster_version = "1.25"

  subnets = [aws_subnet.public_subnet_a.id, aws_subnet.private_subnet.id]
  vpc_id  = aws_vpc.eks_vpc.id

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }

  tags = {
    Name = "eks-cluster"
  }
}