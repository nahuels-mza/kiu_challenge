# Security Group for RDS
module "vpc" {
  source = "../vpc"

}
resource "aws_security_group" "rdssg" {
  name        = "db"
  description = "security group for webservers"
  vpc_id      = module.vpc.vpc_id


  # Allowing traffic only for MySQL and that too from same VPC only.
  ingress {
    description = "MYSQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["172.168.0.0/16"]
  }


  # Allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds sg"
  }
}