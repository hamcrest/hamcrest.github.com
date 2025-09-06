terraform {
  required_providers {
    gandi = {
      version = "~> 2.3.0"
      source  = "go-gandi/gandi"
    }
  }
}
variable "gandi_pat" {
  type      = string
  sensitive = true
}

provider "gandi" {
  personal_access_token = var.gandi_pat
}


variable "domain" {
  type = string
}

data "gandi_domain" "this" {
  name = var.domain
}

resource "gandi_livedns_record" "a" {
  name = "@"
  type = "A"
  ttl  = 3600
  values = [
    "185.199.110.153",
    "185.199.111.153",
    "185.199.109.153",
    "185.199.108.153",
  ]
  zone = data.gandi_domain.this.name
}

resource "gandi_livedns_record" "www" {
  name = "www"
  type = "CNAME"
  ttl  = 3600
  values = [
    "hamcrest.github.io."
  ]
  zone = data.gandi_domain.this.name
}

resource "gandi_livedns_record" "github_pages" {
  name = "_github-pages-challenge-hamcrest"
  type = "TXT"
  ttl  = 10800
  values = [
    "\"109f0d722de274783b6d3065b747a2\""
  ]
  zone = data.gandi_domain.this.name
}
