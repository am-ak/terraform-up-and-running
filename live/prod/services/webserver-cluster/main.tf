terraform {
  backend "s3" {
    key = "prod/services/webserver-cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "webserver_cluster" {
  source                 = "../../../modules/services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "terraform-state-e48fec89-8981-bad6-0ce9-1de8a7f0260e"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"
  instance_type          = "t3.micro"
  min_size               = 2
  max_size               = 2
  custom_tags = {
    Owner     = "team-foo"
    ManagedBy = "terraform"
  }
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  scheduled_action_name  = "scale-out-during-business-hours"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 10
  recurrence             = "0 9 * * *"
  autoscaling_group_name = module.webserver_cluster.asg_name
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  scheduled_action_name  = "scale-in-at-night"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  recurrence             = "0 17 * * *"
  autoscaling_group_name = module.webserver_cluster.asg_name
}

output "alb_dns_name" {
  value       = module.webserver_cluster.alb_dns_name
  description = "The domain name of the load balancer"
}