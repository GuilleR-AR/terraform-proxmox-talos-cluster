resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type = "iso"
  datastore_id = var.ci_disk_storage
  node_name    = var.target_node

  file_name               = "${var.cluster_name}-talos-${var.talos_version}-nocloud-amd64.img"
  url                     = var.url == null ? "https://factory.talos.dev/image/${talos_image_factory_schematic.talos_schematic.id}/${var.talos_version}/nocloud-amd64.raw.xz" : var.url
  decompression_algorithm = var.decompression_algorithm
  overwrite               = false
}
