provider "aws"{
  shared_config_files      = ["/root/.aws/config"]
  shared_credentials_files = ["/root/.aws/credentials"]
  profile                  = "default"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }

  required_version = "~> 1.0"
}