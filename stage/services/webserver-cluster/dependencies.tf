data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "terraform-state-e48fec89-8981-bad6-0ce9-1de8a7f0260e"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "eu-north-1"
  }
}