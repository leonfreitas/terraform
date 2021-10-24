terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.8.0"
    }
  }
}

provider "proxmox" {
  pm_log_enable = true
  pm_log_file = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default = "debug"
    _capturelog = ""
  }
  # pm_timeout = 2000
  # url is the hostname (FQDN if you have one) for the proxmox host you'd like to connect to to issue the commands. my proxmox host is 'prox-1u'. Add /api2/json at the end for the API
  pm_api_url = "https://10.10.100.2:8006/api2/json"
  # api token id is in the form of: <username>@pam!<tokenId>
  pm_api_token_id = "terraform@pam!token_id"
  # this is the full secret wrapped in quotes. don't worry, I've already deleted this from my proxmox cluster by the time you read this post
  pm_api_token_secret = "07db6919-c664-4d45-9d8c-4b59140e0b3d"
  # leave tls_insecure set to true unless you have your proxmox SSL certificate situation fully sorted out (if you do, you will know)
  pm_tls_insecure = true
}
