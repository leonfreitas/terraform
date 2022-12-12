resource "proxmox_vm_qemu" "k8s-master" {
  count = 1
  name = "k8s-master-${count.index + 1}"
  target_node = var.proxmox_host
  clone = var.template_name
  agent = 1
  os_type = "Linux"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "20G"
    type = "scsi"
    storage = "datastore"
    iothread = 1
  }

  connection {
        type        = "ssh"
        host        = self.ssh_host
        user        = var.ssh_user
        private_key = "${file("~/.ssh/id_rsa")}"
        port        = self.ssh_port
    }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=10.10.100.5${count.index + 1}/24,gw=10.10.100.1"
  
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
  
}