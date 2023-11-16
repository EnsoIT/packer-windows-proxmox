# Image index
# 1 = Windows Core
# 2 = Windows Desktop
image_index = {
  "core" = 1
  "desktop" = 2
}

node = "pve"
proxmox_url = "https://172.16.50.11:8006/api2/json"

windows_iso = "HDD:iso/SW_DVD9_Win_Server_STD_CORE_2022__64Bit_English_DC_STD_MLF_X22-74290.ISO"
iso_storage = "HDD"
efi_storage = "local-btrfs"
cloud_init_storage = "local-btrfs"

cores = 4
socket = 1
memory = 4096

vlan = 30
bridge = "vmbr0"
disk_storage = "local-btrfs"
disk_size_gb = "60G"

winrm_user = "Administrator"
