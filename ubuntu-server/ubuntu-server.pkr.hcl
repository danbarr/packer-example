packer {
  required_plugins {
    vmware = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/vmware"
    }
  }
}

variable "iso_url" {
  type    = string
  default = "https://releases.ubuntu.com/20.04.4/ubuntu-20.04.4-live-server-amd64.iso"
}

variable "iso_checksum" {
  type    = string
  default = "file:https://releases.ubuntu.com/20.04.4/SHA256SUMS"
}

#      builder      unique name
source "vmware-iso" "ubuntu-server" {
  # VM settings
  guest_os_type = "ubuntu-64"
  version       = "14"
  cpus          = var.vm_cpu_sockets
  cores         = var.vm_cpu_cores
  memory        = var.vm_memory
  disk_size     = var.vm_disk_size
  network       = "nat"
  vmx_data = {
    "firmware" = "efi"
  }

  # Boot settings
  iso_url            = var.iso_url
  iso_checksum       = var.iso_checksum
  cdrom_adapter_type = "sata"
  http_directory     = "ubuntu-server/http/"
  boot_wait          = "5s"
  boot_command = [
    "<esc><wait>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{.HTTPIP}}:{{.HTTPPort}}/\"",
    "<enter><wait>",
    "initrd /casper/initrd",
    "<enter><wait>",
    "boot",
    "<enter>"
  ]
  shutdown_command = "echo '${var.ssh_password}' | sudo -S -E shutdown -P now"

  # Connection settings
  communicator = "ssh"
  ssh_timeout  = "30m"
  ssh_username = var.ssh_user
  ssh_password = var.ssh_password
}

build {
  sources = ["sources.vmware-iso.ubuntu-server"]

  provisioner "shell" {
    execute_command = "echo '${var.ssh_password}' | {{.Vars}} sudo -E -S sh -eux '{{.Path}}'"
    inline          = ["echo 'Packer built this!' >> /etc/motd"]
  }
}