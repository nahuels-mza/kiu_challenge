provider "aws" {
  region = var.region
}

module "db" {
  source = "./db"

}

module "web" {
  source = "./web"
}

module "iam" {
  source = "./iam"
}

# module "eks_cluster"{
#   source = "./eks"
# }
module "vpc"{
  source = "./vpc"
}

output "PrivateIp" {
  value = module.db.PrivateIP #Double check this
}

output "PublicIp" {
  value = module.web.pub_ip
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = module.iam.eks_iam_role_arn
  version = "1.28"

  vpc_config {
    subnet_ids = ["subnet-09c37fdb4c5669f9d","subnet-037624adf72d00634"]
  }
  # cluster_endpoint_public_access = true

  depends_on = [
    module.iam
  ]

}

resource "aws_eks_node_group" "worker-node-group" {
  cluster_name  = var.cluster_name
  node_group_name = "system"
  node_role_arn  = module.iam.eks_iam_role_arn
  subnet_ids = [module.vpc.private_subnet_id]
  instance_types = [var.instance_type]

  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 }


output "endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}