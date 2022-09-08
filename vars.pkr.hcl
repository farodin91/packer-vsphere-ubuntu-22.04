variable "vcenter_server" {
  type        = string
  description = "The fully qualified domain name or IP address of the vCenter Server instance. (e.g. 'vcsa.lab.hyperact.ca')"
}

variable "vsphere_username" {
  type        = string
  description = "The username to login to the vCenter Server instance. (e.g. 'svc-packer@lab.hyperact.ca')"
  sensitive   = true
}

variable "vsphere_password" {
  type        = string
  description = "The password for the login to the vCenter Server instance."
  sensitive   = true
}

variable "vsphere_datacenter" {
  type        = string
  description = "The name of the target vSphere datacenter. (e.g. 'dc01')"
}

variable "vm_guest_os_family" {
  type        = string
  description = "The guest operating system family. Used for naming. (e.g. 'linux')"
}

variable "vm_guest_os_name" {
  type        = string
  description = "The guest operating system name. Used for naming . (e.g. 'ubuntu')"
}

variable "vm_guest_os_version" {
  type        = string
  description = "The guest operating system version. Used for naming. (e.g. '20-04-lts')"
}

variable "vsphere_folder" {
  type        = string
  description = "The name of the target vSphere folder. (e.g. 'templates')"
}

variable "vsphere_cluster" {
  type        = string
  description = "The name of the target vSphere cluster. (e.g. 'prodcl01')"
}

variable "vsphere_datastore" {
  type        = string
  description = "The name of the target vSphere datastore. (e.g. 'vsan01')"
}

variable "vm_cpu_cores" {
  type        = number
  description = "The number of virtual CPUs cores per socket. (e.g. '1')"
}

variable "vm_mem_size" {
  type        = number
  description = "The size for the virtual memory in MB. (e.g. '2048')"
}

variable "vm_firmware" {
  type        = string
  description = "The virtual machine firmware. (e.g. 'efi-secure'. 'efi', or 'bios')"
  default     = "efi-secure"
}

variable "vsphere_network" {
  type        = string
  description = "The name of the target vSphere network segment. (e.g. 'mgmt')"
}

variable "vm_disk_size" {
  type        = number
  description = "The size for the virtual disk in MB. (e.g. '40960')"
}