resource "local_file" "hosts_ansible" {
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

resource "local_file" "hosts_linux" {
    filename = "./hosts"
    content = <<-EOT
# Your system has configured 'manage_etc_hosts' as True.
# As a result, if you wish for changes to this file to persist
# then you will need to either
# a.) make changes to the master file in /etc/cloud/templates/hosts.debian.tmpl
# b.) change or remove the value of 'manage_etc_hosts' in
#     /etc/cloud/cloud.cfg or cloud-config from user-data
#
127.0.0.1 localhost

# The following lines are desirable for IPv6 capable hosts
::1 localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

%{for ip in proxmox_vm_qemu.k8s-master.* ~}
${ip.default_ipv4_address} ${ip.name} ${ip.name} 
%{ endfor ~}
%{for ip in proxmox_vm_qemu.k8s-worker.* ~}
${ip.default_ipv4_address} ${ip.name} ${ip.name} 
%{ endfor ~}
EOT
}

output "masters_ips" {
  value = ["${proxmox_vm_qemu.k8s-master.*.default_ipv4_address}"]
}

output "workers_ips" {
  value = ["${proxmox_vm_qemu.k8s-worker.*.default_ipv4_address}"]
}