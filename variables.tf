variable "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
}

variable "location" {
  description = "Azure Region"
}

variable "name_prefix" {
  description = "Name Prefix"
  default     = ""
}

variable "vm_size" {
  description = "Azure virtual machine size"
}

variable "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
}

variable "ssh_private_key_filename" {
  description = "Path to the SSH private key"

  # cannot leave this empty as the file() interpolation will fail later on for the private_key local variable
  # https://github.com/hashicorp/terraform/issues/15605
  default = "/dev/null"
}

variable "image" {
  description = "Source image to boot from"
  type        = "map"
  default     = {}
}

variable "disk_type" {
  description = "Disk Type to Leverage"
  default     = "Standard_LRS"
}

variable "disk_size" {
  description = "Disk Size in GB"
}

variable "resource_group_name" {
  description = "Name of the azure resource group"
}

variable "custom_data" {
  description = "User data to be used on these instances (cloud-init)"
  default     = ""
}

variable "admin_username" {
  description = "SSH User"
}

variable "public_ssh_key" {
  description = "SSH Public Key"
}

variable "allow_stopping_for_update" {
  description = "If true, allows Terraform to stop the instance to update its properties"
  default     = "true"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "hostname_format" {
  description = "Format the hostname inputs are index+1, region, cluster_name"
  default     = "master-%[1]d-%[2]s"
}

variable "subnet_id" {
  description = "Subnet ID"
}

variable "network_security_group_id" {
  description = "Security Group Id"
  default     = ""
}

variable "avset_platform_fault_domain_count" {
  description = "Availabilty set platform fault domain count, differs from location to location"
  default     = 3
}
