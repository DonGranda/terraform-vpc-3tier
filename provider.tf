terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }

  backend "s3" {
    bucket = "myapp-terraform-state-d020620254"
    key    = "devops/infrastructure/s3.tfstate"
    region = "eu-north-1"
  }
}


