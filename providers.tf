terraform {
  required_version = ">= 1.5.3"
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.82.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.8.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
  }
}
