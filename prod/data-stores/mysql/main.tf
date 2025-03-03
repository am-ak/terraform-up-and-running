terraform {
  backend "s3" {
    key = "prod/data-stores/mysql/terraform.tfstate"
  }
}

resource "aws_db_instance" "example" {
  identifier_prefix   = "prod"
  engine              = "mysql"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  skip_final_snapshot = true
  db_name             = "prod_database"
  # Pass those secrets into Terraform via environment variables
  username = var.db_username
  password = var.db_password
}
