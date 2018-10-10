[![Build Status](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-masters/job/master/badge/icon)](https://jenkins-terraform.mesosphere.com/service/dcos-terraform-jenkins/job/dcos-terraform/job/terraform-azurerm-masters/job/master/)

Azure DC/OS Master Instances
============================
This module creates typical master instances used by DC/OS

EXAMPLE
-------

```hcl
module "dcos-master-instances" {
  source  = "dcos-terraform/masters/azurerm"
  version = "~> 0.1"

  admin_username = "admin"
  cluster_name = "production"
  subnet_ids = "string-myid"
  resource_group_name = "example"
  public_ssh_key = "my-ssh-key"

  num_masters = "3"
}
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin_username | admin username | string | - | yes |
| allow_stopping_for_update | If true, allows Terraform to stop the instance to update its properties | string | `true` | no |
| custom_data | User data to be used on these instances (cloud-init) | string | `` | no |
| dcos_instance_os | Operating system to use. Instead of using your own AMI you could use a provided OS. | string | - | yes |
| dcos_version | Specifies which DC/OS version instruction to use. Options: 1.9.0, 1.8.8, etc. See dcos_download_path or dcos_version tree for a full list. | string | - | yes |
| disk_size | disk size | string | - | yes |
| disk_type | Disk Type to Leverage. | string | `Standard_LRS` | no |
| hostname_format | Format the hostname inputs are index+1, region, cluster_name | string | `master-%[1]d-%[2]s` | no |
| image | A storage_image_reference reference. | map | `<map>` | no |
| instance_type | instance type | string | - | yes |
| location | location | string | - | yes |
| name_prefix | Cluster Name | string | - | yes |
| network_security_group_id | network security group id | string | `` | no |
| num_masters | Specify the amount of masters. For redundancy you should have at least 3 | string | - | yes |
| private_backend_address_pool | private backend address pool | list | `<list>` | no |
| public_backend_address_pool | public backend address pool | list | `<list>` | no |
| resource_group_name | resource group name | string | - | yes |
| ssh_private_key_filename | Path to the SSH private key | string | `/dev/null` | no |
| ssh_public_key | SSH public key in authorized keys format (e.g. 'ssh-rsa ..') to be used with the instances. Make sure you added this key to your ssh-agent. | string | - | yes |
| subnet_id | Subnet ID | string | - | yes |
| tags | Add custom tags to all resources | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin_username | admin username |
| prereq_id | prereq id |
| private_ips | List of private ip addresses created by this module |
| public_ips | List of public ip addresses created by this module |

