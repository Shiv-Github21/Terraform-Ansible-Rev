terraform {
    required_version = ">= 1.15.0"

  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 6.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.0"
    }
  }
    backend "s3" {
     bucket = "Udaan_bucket_007"
     key = "terraform/terraform.tfstate"
     region = "us-west-2"
     use_lockfile = true
  }
}
