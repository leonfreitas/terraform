variable "ssh_key" {
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCjqAWGDFnvjKOz6LjqaSRAuBE+bcrvvJbcq8yju1p/+x+B3OfT6WXc39ov83JtJDoJ0HdO2mjRqAOjqv2wUdbqqabKa9+Fh3Ce/Y+Ht/eDfMF4lARMzjeNGGibhaU/xENyCDjLkKtk4Z8sHCgbGc6fv/joKt0ywy5GFGrFP9EkxUsA/eKCB1yU1S0Q+Os9Wl7+doM543yG2Yw/F4hQBGbnGoqFSPCH4M6OGM3McbXNajqxKiuLTgbYB/1G36xXVh3Y/ThQNqA2Lv+BgQZiAiHd4/0BXxYaFQu+ez+sGxhK4O6PxkxsSjD8xFAWvgWnYhyR8gpoWpRjc6aIBA8tQM2F0UDaJIzLyHeK5eL65CPam1x24WjDCKFNIGwPXcl/mqHvcSuDNAs/FnjUHte6anvITu+6iEgmdMuf3wHAV8kH824CflIkqlTKraxqH5vcPHkudiIg1ksPL/QJa96XziIaZPaX4ycSd1hq4QPosD+eZJ5bjfKMqiB9RyKVH8tIXGc= leonardo"
}

variable "ssh_private_key" {
    default = "~/.ssh/id_rsa"
}

variable "proxmox_host" {
    default = "pve"
}

variable "template_name" {
    default = "ubuntu-focal-cloudinit-template"
}

variable "ssh_user" {
    default = "ubuntu"
}

variable "ssh_port" {
    default = "22"
}