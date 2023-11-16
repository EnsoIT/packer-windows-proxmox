# About
This is a Hashicorp Packer script to create a Microsoft Windows Server 2022 Desktop or Core template VM on the Proxmox hypervisor. The template includes the latest Microsoft Windows Updates, virtio drivers and the Cloudbase client software.

## Highlights

- Automates Windows Server 2022 setup and configuration.
- Seamlessly integrates Windows Updates for enhanced security.
- Facilitates CloudBase initialization for cloud environments.
- Enables scalability and standardization in VM template deployment on Proxmox.

# Requirements

- Packer: You need Packer installed on your local system where you plan to execute the script. You can download Packer from the official website (https://www.packer.io/downloads).
- Proxmox: You should have access to a Proxmox virtualization platform. Ensure you have the necessary permissions and credentials to create VM templates on Proxmox.
- Windows Server 2022 ISO: You'll need a copy of the Windows Server 2022 ISO file. Make sure it's accessible and located at the path specified in the script (var.windows_iso).
- Make sure the additional ISO files, such as drivers and scripts, are available at the specified locations (cd_files).

## Packer command cd_files
The packer scripts uses the `cd_files` command and needs one of the following tools to create an ISO.

- xorriso
- mkisofs
- hdiutil (normally found in macOS)
- oscdimg (normally found in Windows as part of the Windows ADK)

# Links and sources
Working with cloud-init and Windows is challenging. Windows doesn't accept an encrypted password. This can be fixed with a patch.
More info can be found on on the following git repository: [Geco-IT](https://git.geco-it.net/GECO-IT-PUBLIC/Geco-Cloudbase-Init/src/branch/master).
The Promox forum has a thread about Cloudbase and Windows VM's and how to make it work: [Proxmox Forum](https://forum.proxmox.com/threads/howto-scripts-to-make-cloudbase-work-like-cloudinit-for-your-windows-based-instances.103375/) 

# Usage
1. Change the variables in the `variables.auto.pkrvars.hcl` file and adjust te variables to your needs.
2. Run `packer init .` to initialize packer and install the defined plugins.
3. Run `packer build .` to create a Windows Server 2022 Desktop edition template or run `packer build -var template=core .` to create a Windows Server 2022 Core edition template.
