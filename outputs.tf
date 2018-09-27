# Number of Instance
output "num_masters" {
  description = "Specify the amount of masters. For redundancy you should have at least 3"
  value = "${var.num_masters}"
}

# Cluster Name
output "name_prefix" {
  description = "Cluster Name"
  value = "${var.name_prefix}"
}

# Instance Type
output "instance_type" {
  description = "instance type"
  value = "${var.instance_type}"
}

# DCOS Version for prereq install
output "dcos_version" {
  description = "Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list."
  value = "${var.dcos_version}"
}

# Tested OSes to install with prereq
output "dcos_instance_os" {
  description = "Operating system to use. Instead of using your own AMI you could use a provided OS."
  value = "${var.dcos_instance_os}"
}

# Source image to boot from
output "image" {
  description = "image"
  value = "${var.image}"
}

# Disk Type to Leverage
output "disk_type" {
  description = "Disk Type to Leverage."
  value = "${var.disk_type}"
}

# Disk Size in GB
output "disk_size" {
  description = "disk size"
  value = "${var.disk_size}"
}

# Resource Group Name
output "resource_group_name" {
  description = "resource group name"
  value = "${var.resource_group_name}"
}

# Customer Provided Userdata
output "user_data" {
  description = "User data to be used on these instances (cloud-init)"
  value = "${var.user_data}"
}

# SSH User
output "admin_username" {
  description = "admin username"
  value = "${module.dcos-master-instances.admin_username}"
}

# SSH Public Key
output "public_ssh_key" {
  description = "public ssh key"
  value = "${var.public_ssh_key}"
}

# Private IP Addresses
output "private_ips" {
  description = "List of private ip addresses created by this module"
  value = ["${module.dcos-master-instances.private_ips}"]
}

# Public IP Addresses
output "public_ips" {
  description = "List of public ip addresses created by this module"
  value = ["${module.dcos-master-instances.public_ips}"]
}

# Master Load Balancer Address
output "lb.fqdn" {
  description = "lb.fqdn"
  value = "${module.master-lb.elb_address}"
}

# Returns the ID of the prereq script
output "prereq_id" {
  description = "prereq id"
  value = "${module.dcos-master-instances.prereq_id}"
}
