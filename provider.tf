terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
    region = var.region
}

provider "cloudflare" {
}