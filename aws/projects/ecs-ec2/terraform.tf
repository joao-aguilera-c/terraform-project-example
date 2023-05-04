terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
  }

  required_version = "~> 1.3"
}