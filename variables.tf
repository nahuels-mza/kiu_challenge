variable "region" {
  default = "us-west-1"
}

output "region" {
  description = "AWS region"
  value       = var.region
}
variable "cluster_name" {
  default = "kiu-test"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ingress_port" {
  type    = list(number)
  default = [80, 8080, 443]

}
variable "egress_port" {
  type    = list(number)
  default = [80, 80, 443]

}