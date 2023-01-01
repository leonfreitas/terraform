resource "proxmox_vm_qemu" "k8s-master" {
  count = var.vm_master_count
  name = "vm-k8s-master-${count.index + 1}"
  target_node = data.vault_generic_secret.proxmox.data["proxmox_host"]
  clone = var.template_name
  clone_wait = 360
  agent = 1
  os_type = "Linux"
  cores = 4
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "virtio0"

  disk {
    slot = 0
    size = "10G"
    type = "virtio"
    storage = "datastore"
    iothread = 1
  }

  connection {
        type        = "ssh"
        host        = self.ssh_host
        user        = data.vault_generic_secret.proxmox.data["ssh_user"]
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
  ${data.vault_generic_secret.proxmox.data["ssh_key"]}
  EOF

  provisioner "remote-exec" {
    connection {
      host = self.default_ipv4_address
      user = data.vault_generic_secret.proxmox.data["ssh_user"]
      file = self.private_key
    }
    inline = [
      "echo 'Conectado!'"
    ]
  }
}