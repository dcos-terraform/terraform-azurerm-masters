# Number of Instance
output "num_masters" {
  value = "${var.num_masters}"
}

# Cluster Name
output "name_prefix" {
  value = "${var.name_prefix}"
}

# Instance Type
output "instance_type" {
  value = "${var.instance_type}"
}

# DCOS Version for prereq install
output "dcos_version" {
  value = "${var.dcos_version}"
}

# Tested OSes to install with prereq
output "dcos_instance_os" {
  value = "${var.dcos_instance_os}"
}

# Source image to boot from
output "image" {
  value = "${var.image}"
}

# Disk Type to Leverage
output "disk_type" {
  value = "${var.disk_type}"
}

# Disk Size in GB
output "disk_size" {
  value = "${var.disk_size}"
}

# Resource Group Name
output "resource_group_name" {
  value = "${var.resource_group_name}"
}

# Customer Provided Userdata
output "user_data" {
  value = "${var.user_data}"
}

# SSH User
output "admin_username" {
  value = "${module.dcos-master-instances.admin_username}"
}

# SSH Public Key
output "public_ssh_key" {
  value = "${var.public_ssh_key}"
}

# Private IP Addresses
output "private_ips" {
  value = ["${module.dcos-master-instances.private_ips}"]
}

# Public IP Addresses
output "public_ips" {
  value = ["${module.dcos-master-instances.public_ips}"]
}

# Master Load Balancer Address
output "lb.fqdn" {
  value = "${module.master-lb.elb_address}"
}
