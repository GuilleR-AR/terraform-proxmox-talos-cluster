resource "proxmox_virtual_environment_vm" "talos_cp" {
  count       = var.count_cp
  name        = "${var.name}-cp-${count.index}"
  description = var.desc
  tags        = ["${local.module_tags},${var.tags},controlplane"]
  node_name   = var.target_node
  on_boot     = true
  vm_id       = var.vmid + count.index

  cpu {
    cores = var.cores
    type  = var.cpu_type
  }

  memory {
    dedicated = var.memory
  }

  agent {
    enabled = var.agent
    timeout = var.timeout
  }

  network_device {
    bridge = var.nw_bridge
  }

  disk {
    datastore_id = var.ci_disk_storage
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = var.disk_interface
    size         = var.disk_size
  }

  operating_system {
    type = var.os_type
  }

  initialization {
    datastore_id = var.vm_disk_storage
    ip_config {
      ipv4 {
        address = "${cidrhost(var.subnet_cidr, var.starting_ip + count.index)}/${element(split("/", var.subnet_cidr), 1)}"
        gateway = element(split("/", var.subnet_cidr), 0)
      }
    }
  }
}

resource "proxmox_virtual_environment_vm" "talos_worker" {
  count       = var.count_worker
  name        = "${var.name}-worker-${count.index}"
  description = var.desc
  tags        = ["${local.module_tags},${var.tags},worker"]
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
    timeout = var.timeout
  }

  network_device {
    bridge = var.nw_bridge
  }

  disk {
    datastore_id = var.ci_disk_storage
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = var.disk_interface
    size         = var.disk_size
  }

  operating_system {
    type = var.os_type
  }

  initialization {
    datastore_id = var.vm_disk_storage
    ip_config {
      ipv4 {
        address = "${cidrhost(var.subnet_cidr, var.starting_ip + var.count_cp + count.index)}/${element(split("/", var.subnet_cidr), 1)}"
        gateway = element(split("/", var.subnet_cidr), 0)
      }
    }
  }
  depends_on = [proxmox_virtual_environment_vm.talos_cp]
}
