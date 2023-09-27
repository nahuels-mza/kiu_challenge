resource "aws_instance" "db" {
  ami           = "ami-0513ae30100cf3cf5"
  instance_type = "t2.micro"
  tags = {
    Name = "DB Kiu Server"
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}