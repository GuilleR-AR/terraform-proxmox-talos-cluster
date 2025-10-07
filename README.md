# tf-talos-proxmox-module
Terraform module for deploying a kubernetes cluster on proxmox using Talos images
This was imspired by:
https://olav.ninja/talos-cluster-on-proxmox-with-terraform

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.3 |
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.2.2 |
| <a name="requirement_proxmox"></a> [proxmox](#requirement\_proxmox) | 0.82.0 |
| <a name="requirement_talos"></a> [talos](#requirement\_talos) | 0.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.2.2 |
| <a name="provider_proxmox"></a> [proxmox](#provider\_proxmox) | 0.82.0 |
| <a name="provider_talos"></a> [talos](#provider\_talos) | 0.8.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [proxmox_virtual_environment_download_file.talos_nocloud_image](https://registry.terraform.io/providers/bpg/proxmox/0.82.0/docs/resources/virtual_environment_download_file) | resource |
| [proxmox_virtual_environment_file.user_data_cloud_config](https://registry.terraform.io/providers/bpg/proxmox/0.82.0/docs/resources/virtual_environment_file) | resource |
| [proxmox_virtual_environment_vm.talos_cp](https://registry.terraform.io/providers/bpg/proxmox/0.82.0/docs/resources/virtual_environment_vm) | resource |
| [proxmox_virtual_environment_vm.talos_worker](https://registry.terraform.io/providers/bpg/proxmox/0.82.0/docs/resources/virtual_environment_vm) | resource |
| [talos_cluster_kubeconfig.kubeconfig](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/resources/cluster_kubeconfig) | resource |
| [talos_machine_bootstrap.bootstrap](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/resources/machine_bootstrap) | resource |
| [talos_machine_configuration_apply.cp_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_configuration_apply.worker_config_apply](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/resources/machine_configuration_apply) | resource |
| [talos_machine_secrets.machine_secrets](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/resources/machine_secrets) | resource |
| [local_file.ssh_public_key](https://registry.terraform.io/providers/hashicorp/local/2.2.2/docs/data-sources/file) | data source |
| [talos_client_configuration.talosconfig](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/data-sources/client_configuration) | data source |
| [talos_cluster_health.health](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/data-sources/cluster_health) | data source |
| [talos_machine_configuration.machineconfig_cp](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/data-sources/machine_configuration) | data source |
| [talos_machine_configuration.machineconfig_worker](https://registry.terraform.io/providers/siderolabs/talos/0.8.0/docs/data-sources/machine_configuration) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent"></a> [agent](#input\_agent) | Enable QEMU Guest Agent | `bool` | `true` | no |
| <a name="input_ci_disk_storage"></a> [ci\_disk\_storage](#input\_ci\_disk\_storage) | Datastore ID for the cloud-init disk | `string` | `"local"` | no |
| <a name="input_ciuser"></a> [ciuser](#input\_ciuser) | Cloud-init user name | `string` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Talos cluster | `string` | `"homelab"` | no |
| <a name="input_cores"></a> [cores](#input\_cores) | Number of CPU cores per VM | `number` | n/a | yes |
| <a name="input_count_cp"></a> [count\_cp](#input\_count\_cp) | Number of control plane nodes | `number` | `1` | no |
| <a name="input_count_worker"></a> [count\_worker](#input\_count\_worker) | Number of worker nodes | `number` | `3` | no |
| <a name="input_cpu_type"></a> [cpu\_type](#input\_cpu\_type) | CPU type | `string` | `"x86-64-v2-AES"` | no |
| <a name="input_default_gateway"></a> [default\_gateway](#input\_default\_gateway) | Default gateway for the Talos cluster | `string` | `"<IP address of your default gateway>"` | no |
| <a name="input_desc"></a> [desc](#input\_desc) | Description for the VMs | `string` | `"Managed by Terraform"` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of the SCSI0 disk in GB | `number` | `20` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory size in MB per VM | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Base name for the VMs | `string` | `"talos"` | no |
| <a name="input_nw_bridge"></a> [nw\_bridge](#input\_nw\_bridge) | Network bridge for the VMs | `string` | n/a | yes |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating system type for the VMs | `string` | `"l26"` | no |
| <a name="input_starting_ip"></a> [starting\_ip](#input\_starting\_ip) | Starting IP address for the VMs | `number` | n/a | yes |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | Subnet CIDR for the Talos cluster | `string` | `"10.2.50"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the VMs | `string` | n/a | yes |
| <a name="input_target_node"></a> [target\_node](#input\_target\_node) | Proxmox VE node name where the VMs will be created | `string` | n/a | yes |
| <a name="input_vm_disk_storage"></a> [vm\_disk\_storage](#input\_vm\_disk\_storage) | Datastore ID for the SCSI0 disk | `string` | `"local-lvm"` | no |
| <a name="input_vmid"></a> [vmid](#input\_vmid) | Starting VM ID for the VMs | `number` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | Kubeconfig for the Talos cluster |
| <a name="output_talosconfig"></a> [talosconfig](#output\_talosconfig) | Kubeconfig for the Talos cluster |
<!-- END_TF_DOCS -->
