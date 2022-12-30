variable "ssh_key" {
  default = []
}

variable "ssh_user" {
  default = []
}

variable "proxmox_host" {
    default = []
}

variable "template_name" {
    default = "ubuntu-server-focal-kubernetes"
}

variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
}

variable "vm_master_count" {
  type = number
}

variable "vm_worker_count" {
  type = number
}




