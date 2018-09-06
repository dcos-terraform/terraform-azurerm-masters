###
# Instance Variables
###
# Number of Instance
variable "num_masters" {}

# Location (region)
variable "location" {}

# Cluster Name
variable "name_prefix" {}

# Instance Type
variable "instance_type" {}

# DCOS Version for prereq install
variable "dcos_version" {}

# Tested OSes to install with prereq
variable "dcos_instance_os" {}

# Private SSH Key Filename Optional
variable "ssh_private_key_filename" {
  # cannot leave this empty as the file() interpolation will fail later on for the private_key local variable
  # https://github.com/hashicorp/terraform/issues/15605
  default = "/dev/null"
}

# Source image to boot from. We assume the user has already take care of the prereq during this step.
variable "image" {}

# Disk Type to Leverage. The managed disk type. (optional)
variable "disk_type" {
  default = "Standard_LRS"
}

# Disk Size in GB
variable "disk_size" {}

# Resource Group Name
variable "resource_group_name" {}

# Customer Provided Userdata
variable "user_data" {
  default = ""
}

# SSH User
variable "admin_username" {}

# SSH Public Key
variable "public_ssh_key" {}

# Allow stopping for update (bool)
variable "allow_stopping_for_update" {
  default = "true"
}

# Add special tags to the resources created by this module
variable "tags" {
  type        = "map"
  default     = {}
}

# Format the hostname inputs are index+1, region, name_prefix
variable "hostname_format" {
  default = "instance-%[1]d-%[2]s"
}

# Subnet ID
variable "subnet_id" {}
