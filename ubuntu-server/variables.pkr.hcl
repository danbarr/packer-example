variable ssh_user {
  description = "The user account for SSH connections."
  default     = "packer"
}

variable ssh_password {
  description = "The password for SSH connections."
  sensitive   = true
}

variable vm_cpu_sockets {
  description = "The number of vCPU sockets."
}

variable vm_cpu_cores {
  description = "The number of vCPU cores per socket."
}

variable vm_memory {
  description = "The amount of RAM, in MB."
}

variable vm_disk_size {
  description = "The amount of virtual disk to allocate, in MB."
}