resource "talos_machine_secrets" "machine_secrets" {}

data "talos_client_configuration" "talosconfig" {
  count                = var.count_cp
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  endpoints            = ["${var.subnet_cidr}.${var.starting_ip + count.index}"]
}

data "talos_machine_configuration" "machineconfig_cp" {
  count            = var.count_cp
  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${var.subnet_cidr}.${var.starting_ip + count.index}:6443"
  machine_type     = "controlplane"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "cp_config_apply" {
  count                       = var.count_cp
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_cp[0].machine_configuration
  node                        = "${var.subnet_cidr}.${var.starting_ip + count.index}"
  depends_on                  = [proxmox_virtual_environment_vm.talos_cp]
}

data "talos_machine_configuration" "machineconfig_worker" {
  count            = var.count_cp
  cluster_name     = var.cluster_name
  cluster_endpoint = "https://${var.subnet_cidr}.${var.starting_ip + count.index}:6443"
  machine_type     = "worker"
  machine_secrets  = talos_machine_secrets.machine_secrets.machine_secrets
}

resource "talos_machine_configuration_apply" "worker_config_apply" {
  count                       = var.count_worker
  client_configuration        = talos_machine_secrets.machine_secrets.client_configuration
  machine_configuration_input = data.talos_machine_configuration.machineconfig_worker[0].machine_configuration
  node                        = "${var.subnet_cidr}.${var.starting_ip + count.index + var.count_cp}"
  depends_on                  = [proxmox_virtual_environment_vm.talos_worker]
}

resource "talos_machine_bootstrap" "bootstrap" {
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = "${var.subnet_cidr}.${var.starting_ip}"
  depends_on           = [talos_machine_configuration_apply.cp_config_apply]
}

data "talos_cluster_health" "health" {
  client_configuration = data.talos_client_configuration.talosconfig[0].client_configuration
  control_plane_nodes  = ["${var.subnet_cidr}.${var.starting_ip + var.count_cp - 1}"]
  worker_nodes         = formatlist("${var.subnet_cidr}.%s", "${(range(var.starting_ip + var.count_cp, var.starting_ip + var.count_worker + var.count_cp))}")
  endpoints            = data.talos_client_configuration.talosconfig[0].endpoints
  depends_on           = [talos_machine_configuration_apply.cp_config_apply, talos_machine_configuration_apply.worker_config_apply]
}

resource "talos_cluster_kubeconfig" "kubeconfig" {
  client_configuration = talos_machine_secrets.machine_secrets.client_configuration
  node                 = "${var.subnet_cidr}.${var.starting_ip}"
  depends_on           = [talos_machine_bootstrap.bootstrap, data.talos_cluster_health.health] #
}
