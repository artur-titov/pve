# -------------------------------------------------------------+
# Proxmox
# connection credentials.
#
provider "proxmox" {
  pm_api_url = var.pve_api_url
  pm_tls_insecure = true # By default Proxmox Virtual Environment uses self-signed certificates.
  pm_user = var.tf_user
  pm_password = var.tf_user_password
}
