variable "region" {
  default = "sa-east-1"
}

variable "cluster_name" {
  default = "kiu-test"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "availability_zone" {
  description = ""
  type        = list(string)
  default     = ["sa-east-1a,sa-east-1b,sa-east-1c"]

}
variable "ingress_port" {
  type    = list(number)
  default = [80, 8080, 443]

}
variable "egress_port" {
  type    = list(number)
  default = [80, 80, 443]

}