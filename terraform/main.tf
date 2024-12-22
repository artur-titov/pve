# ---------------------------------------------------------------------+
# Proxmox
#
resource "proxmox_lxc" "k8s" {
  count = 3
  
  # ---------------------------------+
  # Instance parameters:
  target_node  = "node"
  vmid         = "30${count.index}"
  hostname     = "lxc-k8s-${count.index}"
  ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  ostype       = "ubuntu" 
  onboot       = true
  tags         = "k8s-tf"

  # ---------------------------------+
  # Container parameters:
  cores        = 2
  memory       = 2048
  swap         = 0
  unprivileged = true

  rootfs {
    storage = "local-lvm"
    size    = "10G"
  }

  network {
    name   = "eth0"
    gw     = "192.168.1.1"
    bridge = "vmbr0"
    ip     = "192.168.1.13${count.index}/24"
  }
}
