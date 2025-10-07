## talos

variable "cluster_name" {
  type        = string
  default     = "homelab"
  description = "Name of the Talos cluster"
}

variable "default_gateway" {
  type        = string
  default     = "<IP address of your default gateway>"
  description = "Default gateway for the Talos cluster"
}

### vms
variable "count_cp" {
  type        = number
  description = "Number of control plane nodes"
  default     = 1
}

variable "count_worker" {
  type        = number
  description = "Number of worker nodes"
  default     = 3
}

variable "vmid" {
  type        = number
  description = "Starting VM ID for the VMs"
}

variable "subnet_cidr" {
  type        = string
  default     = "10.2.50"
  description = "Subnet CIDR for the Talos cluster"
}

variable "desc" {
  type        = string
  description = "Description for the VMs"
  default     = "Managed by Terraform"

}
variable "agent" {
  type        = bool
  description = "Enable QEMU Guest Agent"
  default     = true
}

variable "cores" {
  type        = number
  description = "Number of CPU cores per VM"
}

variable "cpu_type" {
  type        = string
  description = "CPU type"
  default     = "x86-64-v2-AES"

}
variable "memory" {
  type        = number
  description = "Memory size in MB per VM"

}

variable "ci_disk_storage" {
  type        = string
  description = "Datastore ID for the cloud-init disk"
  default     = "local"

}
variable "disk_size" {
  type        = number
  description = "Size of the SCSI0 disk in GB"
  default     = 20

}
variable "vm_disk_storage" {
  type        = string
  description = "Datastore ID for the SCSI0 disk"
  default     = "local-lvm"

}

variable "name" {
  type        = string
  description = "Base name for the VMs"
  default     = "talos"

}
### common

variable "target_node" {
  type        = string
  description = "Proxmox VE node name where the VMs will be created"

}

variable "nw_bridge" {
  type        = string
  description = "Network bridge for the VMs"

}


variable "os_type" {
  type        = string
  description = "Operating system type for the VMs"
  default     = "l26" # Linux Kernel 2.6 - 5.X.
}


variable "ciuser" {
  type        = string
  description = "Cloud-init user name"

}

variable "tags" {
  type        = string
  description = "Tags to assign to the VMs"
}
variable "starting_ip" {
  type        = number
  description = "Starting IP address for the VMs"
}
