locals {
  tf_module_name    = "terraform-proxmox-talos-cluster"
  tf_module_version = "0-0-2"
  module_tags       = "${local.tf_module_name}_${local.tf_module_version}"
}
