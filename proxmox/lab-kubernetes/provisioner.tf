# resource "time_sleep" "wait_30_seconds" {
#   depends_on = [local_file.hosts]

#   create_duration = "120s"
# }

resource "null_resource" "config" {
    provisioner "local-exec" {
        command = "ansible -i ./ansible/hosts.ini all -m ping"
    }
    #depends_on = [local_file.hosts,time_sleep.wait_30_seconds]
    depends_on = [local_file.hosts]
}