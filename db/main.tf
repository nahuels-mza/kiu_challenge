resource "aws_db_instance" "kiu_database" {
  allocated_storage = 20
  storage_type      = "gp3"
  depends_on        = [aws_security_group.rdssg]

  engine         = "mysql"
  engine_version = "5.7"

  instance_class         = "db.t2.micro"
  vpc_security_group_ids = [aws_security_group.rdssg.id]

  username               = "dbuser"
  password               = "dbpassword"
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = true
  skip_final_snapshot    = true
}

output "DatabaseName" {
  value = aws_db_instance.kiu_database.db_name
}