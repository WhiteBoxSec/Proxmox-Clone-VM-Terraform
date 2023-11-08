# Proxmox API configuration
proxmox_api_url      = "https://10.10.10.10:8006/api2/json"  # Proxmox IP or hostname
proxmox_username     = "user@pve!user"
proxmox_password     = "N/A" # Not needed if using API Token
proxmox_api_token      = "user@pve!user" # Not needed if using password
proxmox_api_secret      = "XXXX-XXXX-XXXX-XXXX-XXXX" # Same
proxmox_tls_insecure = "true"

# Container configuration
name_prefix = "Kali-Host"
client_name = "Client-A"
template = "Kali-Packer-Test"
storage = "local-lvm"
user_password = "testpassword"
ssh_keys = "ssh-rsa AAAAB3NzaC1yXXXXXXXXXXXXXXXX"

# Resource allocation
cores = 2
socket = 1
disk_size = "40G"
memory = 4096
balloon = 2048

# Network configuration
network_bridge = "vmbr0"
network_ipv4 = "10.10.10.100/24"
network_gw = "10.10.10.1"

# Node
node = "10.10.10.10"