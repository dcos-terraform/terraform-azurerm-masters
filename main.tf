provider "azurerm" {}

locals {
  private_key = "${file(var.ssh_private_key_filename)}"
  agent       = "${var.ssh_private_key_filename == "/dev/null" ? true : false}"
}

module "dcos-tested-oses" {
  source  = "dcos-terraform/azurerm-tested-oses/template"
  version = "~> 0.0"

  providers = {
    google = "azurerm"
  }

  os           = "${var.dcos_instance_os}"
  region       = "${var.azure_region}"
  dcos_version = "${var.dcos_version}"
}

# instance Node
resource "azurerm_managed_disk" "instance_managed_disk" {
  count                = "${var.num_of_instances}"
  name                 = "${data.template_file.cluster-name.rendered}-instance-${count.index + 1}"
  location             = "${var.azure_region}"
  resource_group_name  = "${azurerm_resource_group.dcos.name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.instance_disk_size}"
}

# Public IP addresses for the Public Front End load Balancer
resource "azurerm_public_ip" "instance_public_ip" {
  count                        = "${var.num_of_instances}"
  name                         = "${data.template_file.cluster-name.rendered}-instance-pub-ip-${count.index + 1}"
  location                     = "${var.azure_region}"
  resource_group_name          = "${azurerm_resource_group.dcos.name}"
  public_ip_address_allocation = "dynamic"
  domain_name_label = "${data.template_file.cluster-name.rendered}-instance-${count.index + 1}"

  tags = "${merge(var.tags, map("Name", format(var.hostname_format, (count.index + 1), var.region, var.cluster_name),
                                "Cluster", var.cluster_name))}"
}

# Create an availability set
resource "azurerm_availability_set" "instance_av_set" {
  name                         = "${data.template_file.cluster-name.rendered}-instance-avset"
  location                     = "${var.azure_region}"
  resource_group_name          = "${azurerm_resource_group.dcos.name}"
  platform_fault_domain_count  = 3
  platform_update_domain_count = 1
  managed                      = true
}

# Master VM Coniguration
resource "azurerm_virtual_machine" "instance" {
    name                             = "${data.template_file.cluster-name.rendered}-instance-${count.index + 1}"
    location                         = "${var.azure_region}"
    resource_group_name              = "${azurerm_resource_group.dcos.name}"
    network_interface_ids            = ["${azurerm_network_interface.instance_nic.*.id[count.index]}"]
    availability_set_id              = "${azurerm_availability_set.instance_av_set.id}"
    vm_size                          = "${var.azure_instance_instance_type}"
    count                            = "${var.num_of_instances}"
    delete_os_disk_on_termination    = true
    delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${module.azure-tested-oses.azure_publisher}"
    offer     = "${module.azure-tested-oses.azure_offer}"
    sku       = "${module.azure-tested-oses.azure_sku}"
    version   = "${module.azure-tested-oses.azure_version}"
  }

  storage_os_disk {
    name              = "os-disk-instance-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name            = "${azurerm_managed_disk.instance_managed_disk.*.name[count.index]}"
    managed_disk_id = "${azurerm_managed_disk.instance_managed_disk.*.id[count.index]}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${azurerm_managed_disk.instance_managed_disk.*.disk_size_gb[count.index]}"
  }

  os_profile {
    computer_name  = "instance-${count.index + 1}"
    admin_username = "${coalesce(var.azure_admin_username, module.azure-tested-oses.user)}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
        path     = "/home/${coalesce(var.azure_admin_username, module.azure-tested-oses.user)}/.ssh/authorized_keys"
        key_data = "${var.ssh_pub_key}"
    }
  }

  # OS init script
  provisioner "file" {
   content = "${module.azure-tested-oses.os-setup}"
   destination = "/tmp/os-setup.sh"

   connection {
    type = "ssh"
    user = "${coalesce(var.azure_admin_username, module.azure-tested-oses.user)}"
    host = "${element(azurerm_public_ip.instance_public_ip.*.fqdn, count.index)}"
    }
 }

 # We run a remote provisioner on the instance after creating it.
  # In this case, we just install nginx and start it. By default,
  # this should be on port 80
    provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/os-setup.sh",
      "sudo bash /tmp/os-setup.sh",
    ]

   connection {
    type = "ssh"
    user = "${coalesce(var.azure_admin_username, module.azure-tested-oses.user)}"
    host = "${element(azurerm_public_ip.instance_public_ip.*.fqdn, count.index)}"
   }
 }

  tags = "${merge(var.tags, map("Name", format(var.hostname_format, (count.index + 1), var.region, var.cluster_name),
                                "Cluster", var.cluster_name))}"
}
