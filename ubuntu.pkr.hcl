locals {
  build_by      = "Built by: HashiCorp Packer ${packer.version}"
  build_date    = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  build_version = formatdate("MMDD.hhmm", timestamp())
}

source "vsphere-iso" "ubuntu" {
    # Connection Configuration
    vcenter_server        = "${var.vcenter_server}"
    username              = "${var.vsphere_username}"
    password              = "${var.vsphere_password}"
    insecure_connection   = "true"
    datacenter            = "${var.vsphere_datacenter}"

    # Location Configuration
    vm_name               = "${var.vm_guest_os_family}-${var.vm_guest_os_name}-${var.vm_guest_os_version}-v${local.build_version}"
    folder                = "${var.vsphere_folder}"
    cluster               = "${var.vsphere_cluster}"
    datastore             = "${var.vsphere_datastore}"

    # Hardware Configuration
    CPUs                  = "${var.vm_cpu_cores}"
    RAM                   = "${var.vm_mem_size}"
    firmware              = "${var.vm_firmware}"
    
    # Enable nested hardware virtualization for VM. Defaults to false.
    NestedHV              = "false"
 
    # Boot Configuration
    boot_command          = [
      "<wait>c",
      "linux /casper/vmlinuz --- autoinstall ds='nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/'",
      "<enter><wait>",
      "initrd /casper/initrd",
      "<enter><wait>",
      "boot",
      "<enter>"
    ]
    boot_wait             = "1s"

    # HTTP Directory Configuration
    http_directory        = "http"

    # Shutdown Configuration
    shutdown_command      = "sudo shutdown -P now"

    # ISO Configuration
    iso_checksum          = "file:https://releases.ubuntu.com/jammy/SHA256SUMS"
    iso_url               = "https://releases.ubuntu.com/jammy/ubuntu-22.04-live-server-amd64.iso"

    # VM Configuration
    guest_os_type         = "ubuntu64Guest"
    notes                 = "Version: v${local.build_version}\nBuilt on: ${local.build_date}\n${local.build_by}"
    disk_controller_type  = ["pvscsi"]
    storage {
      disk_size           = "${var.vm_disk_size}"
      disk_thin_provisioned = "true"
    }
    network_adapters {
      network             = "${var.vsphere_network}"
      network_card        = "vmxnet3"
    }

    # Communicator Configuration
    communicator          = "ssh"
    ssh_username          = "ansible"
    ssh_private_key_file  = "~/.ssh/id_ed25519"
    ssh_timeout           = "20m"

    # Create as template
    convert_to_template   = "true"
}

build {
  sources = ["source.vsphere-iso.ubuntu"]

  provisioner "shell" {
    inline = [
      "while [ ! -f /var/lib/cloud/instance/boot-finished ]; do echo 'Waiting for cloud-init...'; sleep 10; done",
      "sudo rm -rf /etc/netplan/*.yaml"
    ]
  }
}