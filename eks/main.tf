module "iam" {
  source = "../iam"
}
module "vpc" {
  source = "../vpc"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.15.3"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = [module.vpc.private_subnet_id]
  cluster_endpoint_public_access = true

  # eks_managed_node_group_defaults = {
  #   ami_type = "AL2_x86_64"

  # }

  eks_managed_node_groups = {

    system = {
      name = "system-node"

      instance_types = [var.instance_type]

      min_size     = 1
      max_size     = var.max_size_system_node
      desired_size = var.desire_size_system_node
    }

    application = {
      name = "app-node"

      instance_types = [var.instance_type]

      min_size     = 1
      max_size     = var.max_size_app_node
      desired_size = var.desire_size_app_node
    }
  }
  #   depends_on = [
  #     module.iam
  #   ]
}