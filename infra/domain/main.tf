variable "domain" {
  type = string
}

variable "name_servers" {
  type = list(string)
}

resource "null_resource" "updatens-domain" {
  provisioner "local-exec" {
    command = "aws route53domains update-domain-nameservers --region us-east-1 --domain-name ${var.domain} --nameservers Name=${var.name_servers.0} Name=${var.name_servers.1} Name=${var.name_servers.2} Name=${var.name_servers.3}"
  }
}
