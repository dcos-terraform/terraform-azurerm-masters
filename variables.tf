###
# Instance Variables
###
# Number of Instance
variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
}

# Location (region)
variable "location" {
  description = "location"
}

# Cluster Name
variable "name_prefix" {
  description = "Cluster Name"
}

# Instance Type
variable "instance_type" {
  description = "instance type"
}

# DCOS Version for prereq install
variable "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list."
}

# Tested OSes to install with prereq
variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
}

# Private SSH Key Filename Optional
variable "ssh_private_key_filename" {
  description = "Path to the SSH private key"

  # cannot leave this empty as the file() interpolation will fail later on for the private_key local variable
  # https://github.com/hashicorp/terraform/issues/15605
  default = "/dev/null"
}

# Source image to boot from. We assume the user has already take care of the prereq during this step.
variable "image" {
  description = "A storage_image_reference reference."
  type        = "map"
  default     = {}
}

# Disk Type to Leverage. The managed disk type. (optional)
variable "disk_type" {
  description = "Disk Type to Leverage."
  default     = "Standard_LRS"
}

# Disk Size in GB
variable "disk_size" {
  description = "disk size"
}

# Resource Group Name
variable "resource_group_name" {
  description = "resource group name"
}

# Customer Provided Userdata
variable "custom_data" {
  description = "User data to be used on these instances (cloud-init)"
  default     = ""
}

# SSH User
variable "admin_username" {
  description = "admin username"
}

# SSH Public Key
variable "public_ssh_key" {
  description = "public ssh key"
}

# Allow stopping for update (bool)
variable "allow_stopping_for_update" {
  description = "If true, allows Terraform to stop the instance to update its properties"
  default     = "true"
}

# Add special tags to the resources created by this module
variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

# Format the hostname inputs are index+1, region, name_prefix
variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "master-%[1]d-%[2]s"
}

# Subnet ID
variable "subnet_id" {
  description = "Subnet ID"
}

variable "network_security_group_id" {
  description = "network security group id"
  default     = ""
}

variable "public_backend_address_pool" {
  description = "public backend address pool"
  type        = "list"
  default     = []
}

# Private backend address pool
variable "private_backend_address_pool" {
  description = "private backend address pool"
  type        = "list"
  default     = []
}
