terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = ">= 4.67.0"
    }
  }
  required_version = ">= 1.13"

  backend "s3" {
    bucket  = "terraform.offby1.net"
    key     = "hamcrest.org/state.tfstate"
    region  = "us-west-2"
    profile = "hamcrest"
  }
}

provider "aws" {
  profile = "hamcrest"
  region  = "us-west-2"
}

variable "gandi_pat" {
  type      = string
  sensitive = true
}

module "dns" {
  source    = "./dns/"
  domain    = "hamcrest.org"
  gandi_pat = var.gandi_pat
}

