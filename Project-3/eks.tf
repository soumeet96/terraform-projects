module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eks-cluster"
  cluster_version = "1.25"

  subnet_ids = [aws_subnet.public_subnet_a.id, aws_subnet.private_subnet.id]
  vpc_id  = aws_vpc.eks_vpc.id

  eks_managed_node_groups = {
    eks_nodes = {
      desired_size = 2
      max_size     = 3
      min_size     = 1
      instance_types = ["t3.medium"]
      subnet_ids     = [aws_subnet.public_subnet_a.id, aws_subnet.private_subnet.id]
      iam_role         = aws_iam_role.eks_node_role.arn
    }
  }

  tags = {
    Name = "eks-cluster"
  }
}