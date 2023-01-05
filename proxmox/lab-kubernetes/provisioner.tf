# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [local_file.hosts]

#   create_duration = "120s"
# }

resource "null_resource" "config" {
    provisioner "local-exec" {
        command = "ansible-playbook -i ./ansible/hosts.ini ./ansible/play.yml"
    }

    depends_on = [local_file.hosts_ansible]
}