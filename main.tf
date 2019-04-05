/**
 * [![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-masters/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-masters/job/master/)

 * Azure DC/OS Master Instances
 * ============================
 * This module creates typical master instances used by DC/OS
 *
 * EXAMPLE
 * -------
 *
 *```hcl
 * module "dcos-master-instances" {
 *   source  = "dcos-terraform/masters/azurerm"
 *   version = "~> 0.2.0"
 *
 *   admin_username = "admin"
 *   cluster_name = "production"
 *   subnet_ids = "string-myid"
 *   resource_group_name = "example"
 *   public_ssh_key = "my-ssh-key"
 *
 *   num_masters = "3"
 * }
 *```
 */

provider "azurerm" {}

module "dcos-master-instances" {
  source  = "dcos-terraform/instance/azurerm"
  version = "~> 0.2.0"

  providers = {
    azurerm = "azurerm"
  }

  num                       = "${var.num_masters}"
  location                  = "${var.location}"
  name_prefix               = "${var.name_prefix}"
  vm_size                   = "${var.vm_size}"
  dcos_version              = "${var.dcos_version}"
  dcos_instance_os          = "${var.dcos_instance_os}"
  ssh_private_key_filename  = "${var.ssh_private_key_filename}"
  image                     = "${var.image}"
  disk_type                 = "${var.disk_type}"
  disk_size                 = "${var.disk_size}"
  resource_group_name       = "${var.resource_group_name}"
  network_security_group_id = "${var.network_security_group_id}"
  custom_data               = "${var.custom_data}"
  admin_username            = "${var.admin_username}"
  ssh_public_key            = "${var.ssh_public_key}"
  tags                      = "${var.tags}"
  hostname_format           = "${var.hostname_format}"
  subnet_id                 = "${var.subnet_id}"
}
