variable "tf_user" {
    sensitive   = true
    description = "Proxmox api user"
    type        = string
}

variable "tf_user_password" {
    sensitive   = true
    description = "Proxmox api user password"
    type        = string
}

variable "pve_api_url" {
    sensitive   = true
    description = "Proxmox api url"
    type        = string
}
