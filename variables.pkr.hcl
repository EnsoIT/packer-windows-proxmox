# variables
locals {
  proxmox_password = vault("kv/data/proxmox", "password")
  proxmox_user = vault("kv/data/proxmox", "username")
  winrm_password = vault("kv/data/windows", "winrm_password")
  sensitive = true
}


variable "template" {
  type = string 
  default = "desktop" 
  description = "Template type, can be desktop or core"
  validation {
    condition = (var.template == "desktop") || (var.template == "core")
    error_message = "Should be desktop or core."
  }
}

variable "image_index" {
  type = map(string)
}

variable "proxmox_url" {
  type = string
  description = "Proxmox Server URL"
}

variable "node" {
  type = string
  description = "Proxmox cluster node"
}

variable "windows_iso" {
  type = string
  description = "Location of ISO file in the Proxmox environment"
}

variable "iso_storage" {
  type = string
  description = "Proxmox storage location for additional iso files"
}

variable "efi_storage" {
  type = string
  description = "Location of EFI storage on proxmox host"
}

variable "cloud_init_storage" {
  type = string
  description = "Loaction of cloud-init files/iso/yaml config"
}

variable "memory" {
  type = number
  description = "VM memory in MB"
}

variable "cores" {
  type = number
  description = "Amount of CPU cores"
}

variable "socket" {
  type = number
  description = "Amount of CPU sockets"
}

variable "vlan" {
  type = number
  description = "Network VLAN Tag"
}

variable "bridge" {
  type = string
  description = "Network bridge name"
}

variable "disk_storage" {
  type = string
  description = "Disk storage location"
}

variable "disk_size_gb" {
  type = string
  description = " Disk size including GB so <size>GB"
}

variable "winrm_user" {
  type = string
  description = "WinRM user"
}

variable "cdrom_drive" {
  type = string
  description = "CD-ROM Driveletter for extra iso"
  default = "D:"
}
