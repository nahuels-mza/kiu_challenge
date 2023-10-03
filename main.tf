module "web" {
  source = "./web"
}

module "db" {
  source = "./db"
}

module "iam" {
  source = "./iam"
}

module "vpc" {
  source = "./vpc"
}

output "PublicIp" {
  value = module.web.pub_ip
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = module.iam.eks_iam_role_worknodes_arn
  version  = "1.28"

  vpc_config {
    subnet_ids = ["${module.vpc.public_subnet_id[0]}", "${module.vpc.public_subnet_id[1]}"]
  }
  # cluster_endpoint_public_access = true

  depends_on = [
    module.iam
  ]
}

resource "aws_eks_node_group" "system-node-group" {
  cluster_name    = var.cluster_name
  node_group_name = "system"
  node_role_arn   = module.iam.eks_iam_role_worknodes_arn
  subnet_ids      = ["${module.vpc.public_subnet_id[0]}", "${module.vpc.public_subnet_id[1]}"]
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }
  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_node_group" "app-node-group" {
  cluster_name    = var.cluster_name
  node_group_name = "application"
  node_role_arn   = module.iam.eks_iam_role_worknodes_arn
  subnet_ids      = ["${module.vpc.public_subnet_id[0]}", "${module.vpc.public_subnet_id[1]}"]
  instance_types  = [var.instance_type]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }
  depends_on = [aws_eks_cluster.eks_cluster]
}


output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}
output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}