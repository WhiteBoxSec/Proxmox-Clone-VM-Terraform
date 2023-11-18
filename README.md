# Proxmox-Clone-VM-Terraform
Clone VM on Proxmox using Terraform. This is the accompanying script to the Proxmox Packer repo.

Terraform template for cloning Kali cloud-init template in Proxmox. 

It can be modified to clone other cloud-init templates.

## Usage

Add your credentials to the variables file.

How to create a new user and API key.

https://registry.terraform.io/providers/Telmate/proxmox/latest/docs

Username and password auth works too. Uncomment the lines in the files and comment out the API ones. 


Plan the Kali VM clone.
```
terraform plan -out kali-test
```

Apply the plan.
```
terraform apply kali-test
```

Destory the container.
```
terraform destory
```


