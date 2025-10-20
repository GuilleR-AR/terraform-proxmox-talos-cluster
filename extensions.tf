data "talos_image_factory_extensions_versions" "talos_extensions" {
  # get the latest talos version
  talos_version = var.talos_version
  filters = {
    names = var.extensions
  }
}

resource "talos_image_factory_schematic" "talos_schematic" {
  schematic = yamlencode(
    {
      customization = {
        systemExtensions = {
          officialExtensions = data.talos_image_factory_extensions_versions.talos_extensions.extensions_info[*].name
        }
      }
    }
  )
}
