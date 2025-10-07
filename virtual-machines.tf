resource "proxmox_virtual_environment_vm" "talos_cp" {
  count       = var.count_cp
  name        = "${var.name}-cp-${count.index}"
  description = "Managed by Terraform"
  tags        = ["${var.tags},controlplane"]
  node_name   = var.target_node
  on_boot     = true
  vm_id       = var.vmid + count.index

  cpu {
    cores = var.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  agent {
    enabled = var.agent
  }

  network_device {
    bridge = var.nw_bridge
  }

  disk {
    datastore_id = var.ci_disk_storage
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }

  operating_system {
    type = var.os_type
  }

  initialization {
    datastore_id = var.vm_disk_storage
    ip_config {
      ipv4 {
        address = "${var.subnet_cidr}.${var.starting_ip + count.index}/24"
        gateway = var.default_gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
  depends_on = [proxmox_virtual_environment_file.user_data_cloud_config]
}

resource "proxmox_virtual_environment_vm" "talos_worker" {
  count       = var.count_worker
  name        = "${var.name}-worker-${count.index}"
  description = var.desc
  tags        = ["${var.tags},worker"]
  node_name   = var.target_node
  on_boot     = true
  vm_id       = var.vmid + var.count_cp + count.index

  cpu {
    cores = var.cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  agent {
    enabled = var.agent
  }

  network_device {
    bridge = var.nw_bridge
  }

  disk {
    datastore_id = var.ci_disk_storage
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = var.disk_size
  }

  operating_system {
    type = var.os_type
  }

  initialization {
    datastore_id = "local-lvm"
    ip_config {
      ipv4 {
        address = "${var.subnet_cidr}.${var.starting_ip + count.index + 1}/24"
        gateway = var.default_gateway
      }
      ipv6 {
        address = "dhcp"
      }
    }
    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }
  depends_on = [proxmox_virtual_environment_vm.talos_cp, proxmox_virtual_environment_file.user_data_cloud_config]
}
