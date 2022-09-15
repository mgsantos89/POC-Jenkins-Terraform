terraform {
    required_version = ">= 1.0.0"

    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "3.73.0"
      }
    }

    backend "s3" {
        bucket = "mgsantos-remote-state"
        key    = "jenkins-terraform-poc/terraform.tfstate"
        region = "sa-east-1"
    }

}

provider "aws" {
    region = "sa-east-1"

    default_tags {
      tags = {
        owner = "Marco"
        managed-by = "Jenkins/Terraform"
      }
    }
}
module "network" {
  source = "./network"

  cidr_vpc = "10.0.0.0/16"
  cidr_subnet = "10.0.0.0/24"
  enviroment = "Desenvolvimento"
}