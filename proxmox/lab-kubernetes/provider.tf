terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

provider "vault" {
  address = "http://10.10.100.60:8200/"
  token = "hvs.SUNweZwayNq7XjbWDPiuj8Xb"
}

data "vault_generic_secret" "proxmox" {
  path = "kv-terraform/lab-kubernetes"
}

provider "proxmox" {
  pm_log_enable = true
  pm_log_file = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default = "debug"
    _capturelog = ""
  }
  pm_timeout = 200000
  # url is the hostname (FQDN if you have one) for the proxmox host you'd like to connect to to issue the commands. my proxmox host is 'prox-1u'. Add /api2/json at the end for the API
  pm_api_url = data.vault_generic_secret.proxmox.data["proxmox_url"]
  # api token id is in the form of: <username>@pam!<tokenId>
  pm_api_token_id = data.vault_generic_secret.proxmox.data["pm_api_token_id"]
  # this is the full secret wrapped in quotes. don't worry, I've already deleted this from my proxmox cluster by the time you read this post
  pm_api_token_secret = data.vault_generic_secret.proxmox.data["pm_api_token_secret"]
  # leave tls_insecure set to true unless you have your proxmox SSL certificate situation fully sorted out (if you do, you will know)
  pm_tls_insecure = true
}
