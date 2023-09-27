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


output "PrivateIp" {
  value = module.db.PrivateIP #Double check this
}

output "PublicIp" {
  value = module.web.pub_ip
}

# resource "aws_eks_cluster" "eks_cluster" {
#   name     = var.cluster_name
#   role_arn = module.iam.eks_iam_role_arn
#   version = "1.28"

#   vpc_config {
#     subnet_ids = [aws_subnet.private_subnet.id]
#   }
#   cluster_endpoint_public_access = true

#   depends_on = [
#     module.iam
#   ]

# }

# resource "aws_eks_node_group" "worker-node-group" {
#   cluster_name  = var.cluster_name
#   node_group_name = "system"
#   node_role_arn  = aws_iam_role.workernodes.arn
#   subnet_ids = [aws_subnet.private_subnet.id]
#   instance_types = [var.instance_type]

#   scaling_config {
#    desired_size = 1
#    max_size   = 1
#    min_size   = 1
#   }

#   depends_on = [
#    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#   ]
#  }


