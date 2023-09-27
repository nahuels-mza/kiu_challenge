
variable "ingress_port" {
    type = list(number)
    default = [ 80, 8080,443 ]

}
variable "egress_port" {
    type = list(number)
    default = [ 80, 80,443 ]

}
resource "aws_security_group" "web_sg" {
  name = "web security group"
  dynamic "ingress"{
    iterator = port
    for_each = var.ingress_port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress"{
    iterator = port
    for_each = var.egress_port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "sg_name" {
  value = aws_security_group.web_sg.name

}