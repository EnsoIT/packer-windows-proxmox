packer {
  required_plugins {
    windows-update = {
      version = "0.15.0"
      source = "github.com/rgl/windows-update"
    }
    proxmox = {
      version = "~> 1"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}


source "proxmox-iso" "windows2022" {
  
  # Proxmox Host Conection
  proxmox_url = var.proxmox_url 
  insecure_skip_tls_verify =  true
  username = local.proxmox_user
  password = local.proxmox_password
  node = var.node
  
  # BIOS - UEFI
  bios = "ovmf"

  # Machine type
  # Q35 less resource overhead and newer chipset
  machine = "q35"

  efi_config {
    efi_storage_pool = var.efi_storage
    pre_enrolled_keys = true
    efi_type = "4m"
  }

  # Windows Server ISO File
  iso_file = var.windows_iso 
  unmount_iso = true

  additional_iso_files {
    cd_files = ["./build_files/drivers/*","./build_files/scripts/ConfigureRemotingForAnsible.ps1","./build_files/software/virtio-win-guest-tools.exe"]
    cd_content = {
      "autounattend.xml" = templatefile("./build_files/templates/unattend.pkrtpl", {password = local.winrm_password, cdrom_drive = var.cdrom_drive, index = lookup(var.image_index, var.template, "core")})
    }
    cd_label = "Unattend"
    iso_storage_pool = var.iso_storage
    unmount = true
    device = "sata0"
  }
  
  template_name = "templ-win2022-${var.template}"
  template_description = "Created on: ${timestamp()}"
  vm_name = "win22-${var.template}"
  memory = var.memory
  cores = var.cores
  sockets = var.socket
  cpu_type = "host"
  os = "win11"
  scsi_controller = "virtio-scsi-pci"
  cloud_init = false
  cloud_init_storage_pool = var.cloud_init_storage
  
  # Network
  network_adapters {
    model = "virtio"
    bridge = var.bridge
    vlan_tag = var.vlan
  }

  # Storage
  disks  {
    storage_pool = var.disk_storage
    # storage_pool_type = "btrfs"
    type = "scsi"
    disk_size = var.disk_size_gb
    cache_mode = "writeback"
    format = "raw"
  }

  # WinRM
  communicator          = "winrm"
  winrm_username        = var.winrm_user
  winrm_password        = local.winrm_password
  winrm_timeout         = "12h"
  winrm_port            = "5986"
  winrm_use_ssl         = true
  winrm_insecure        = true

  # Boot
  boot_wait = "7s"
  boot_command = [
    "<enter><wait><enter><wait><enter>"
  ]

}

build {
  name = "Proxmox Build"
  sources = ["source.proxmox-iso.windows2022"]

  provisioner "windows-restart" {
  }

  provisioner "windows-update" {
    search_criteria = "IsInstalled=0"
    filters = [
      "exclude:$_.Title -like '*Preview*'",
      "include:$true",
    ]
    update_limit = 25
  }

  provisioner "powershell" {
    script = "./build_files/scripts/InstallCloudBase.ps1"
    pause_before = "1m"
  }

  provisioner "file" {
    source = "./build_files/config/"
    destination = "C://Program Files//Cloudbase Solutions//Cloudbase-Init//conf" 
  }

  provisioner "powershell" {
    inline = [
      "Set-Service cloudbase-init -StartupType Manual",
      "Stop-Service cloudbase-init -Force -Confirm:$false"
      ]
  }

  provisioner "powershell" {   
    inline = [
      "Set-Location -Path \"C:\\Program Files\\Cloudbase Solutions\\Cloudbase-Init\\conf\"",
      "C:\\Windows\\System32\\Sysprep\\Sysprep.exe /oobe /generalize /unattend:unattend.xml"
     ]
  }

}
