resource "aws_instance" "web" {
  ami             = "ami-086f57c50fd910438"
  instance_type   = "t2.micro"
  security_groups = [module.sg.sg_name]
  # user_data = file("../test.sh")
  tags = {
    Name = "Kiu Web Server"
  }
}

module "eip" {
  source      = "../eip"
  instance_id = aws_instance.web.id
}

module "sg" {
  source = "../vpc"
}

output "pub_ip" {
  value = module.eip.PublicIp
}

output "instance_id" {
  value = aws_instance.web.id

}