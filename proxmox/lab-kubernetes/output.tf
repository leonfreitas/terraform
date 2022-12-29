resource "local_file" "hosts" {
    filename = "./ansible/hosts.ini"
    content = <<-EOT
[masters]
%{for ip in proxmox_vm_qemu.k8s-master.*.default_ipv4_address ~}
${ip}
%{ endfor ~}
[workers]
%{for ip in proxmox_vm_qemu.k8s-worker.*.default_ipv4_address ~}
${ip}
%{ endfor ~}
EOT
}

output "masters_ips" {
  value = ["${proxmox_vm_qemu.k8s-master.*.default_ipv4_address}"]
}

output "workers_ips" {
  value = ["${proxmox_vm_qemu.k8s-worker.*.default_ipv4_address}"]
}