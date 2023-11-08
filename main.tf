terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.0.0"
    }
  }
}

variable "proxmox_api_url" {
  description = "The API URL for the Proxmox provider."
  type = string
}

variable "proxmox_api_token" {
  description = "The API token for Proxmox."
  type = string
}

variable "proxmox_api_secret" {
  description = "The API secret for Proxmox."
  type = string
}

variable "proxmox_username" {
  description = "The user for the Proxmox provider."
  type = string
}

# not needed if using API token
variable "proxmox_password" {
  description = "The password for the Proxmox provider."
  type = string
  sensitive = true
}

variable "proxmox_tls_insecure" {
  description = "Whether to disable TLS verification for the Proxmox provider."
  type = bool
}

variable "user_password" {
  description = "The password for the LXC user."
  type = string
  sensitive = true
}

variable "storage" {
  description = "The storage to use for the VM."
  type = string
}

variable "name_prefix" {
  description = "The prefix for the name of the VM."
  type = string
}

variable "client_name" {
  description = "Name of client."
  type = string
}

variable "node" {
  description = "The node where you want the VM to be created at."
  type = string
}

variable "template" {
  description = "The template to clone from."
  type = string
}

variable "memory" {
  description = "The amount of memory for the VM."
  type = number
}

variable "balloon" {
  description = "The amount of balloon memory for the VM."
  type = number
}

variable "cores" {
  description = "The number of cores for the ."
  type = number
}

variable "socket" {
  description = "The number of sockets for the VM."
  type = number
}

variable "disk_size" {
  description = "The disk size for the VM."
  type = string
}

variable "network_bridge" {
  description = "The network bridge for the VM."
  type = string
}

variable "network_ipv4" {
  description = "The IPv4 address for the VM."
  type = string
}

variable "network_gw" {
  description = "The IPv4 gateway for the VM."
  type = string
}

variable "ssh_keys" {
  description = "The SSH keys to use for the VMs."
  type = string
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_username
  # (optional) password auth
  #pm_password     = var.proxmox_password
  pm_tls_insecure = var.proxmox_tls_insecure
  pm_api_token_id = var.proxmox_api_token
  pm_api_token_secret = var.proxmox_api_secret
}

resource "proxmox_vm_qemu" "vm_clone" {
  desc  = "${var.name_prefix} for ${var.client_name} IP=${var.network_ipv4}"
  name     = "${var.name_prefix}-${var.client_name}"
  os_type   = "cloud-init"
  qemu_os   = "l26"

  # (optional) set VMID 
  # vmid = 201
  target_node  = var.node
  clone = var.template
  memory       = var.memory
  balloon      = var.balloon
  cores        = var.cores
  sockets        = var.socket
  scsihw        = "virtio-scsi-pci"
  #password     = var.user_password
  onboot       = true
  oncreate     = true
  agent = 1

  network {
    model = "virtio"
    bridge   = var.network_bridge
    firewall = true
    #optional VLAN tag
    #tag = 99
  }

  # (optional) IP Address and Gateway. 
  # pre-provision must be true.
  # preprovision = true
    # ipconfig0 = "ip=${var.network_ipv4},gw=${var.network_gw}"
    # nameserver = "10.50.50.3"
    
    # (optional) Default User
    # ciuser = "your-username"
    
    # (optional) Add your SSH KEY
    # sshkeys = var.ssh_keys
  
  #hastate      = "started"
  
  disk {
    storage = var.storage
    size    = var.disk_size
    type    = "scsi"
  }
  
  vga {
    type    = "qxl"
    memory    = 64
  }
 
}
