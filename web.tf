resource "digitalocean_droplet" "node1" {
    image = "ubuntu-16-04-x64"
    name = "node1"
    region = "nyc3"
    size = "4gb"
    private_networking = true
    ssh_keys = [
     "${var.ssh_fingerprint}"
     ]
 provisioner "remote-exec" {
   inline = [
     "export PATH=$PATH:/usr/bin",
     # install nginx
     "sudo apt-get update",
     "sudo apt-get -y install nginx"
   ]
   connection {
       user = "root"
       type = "ssh"
       private_key = "${file(var.pvt_key)}"
       timeout = "2m"
   }
 }
}

resource "digitalocean_droplet" "node2" {
    image = "ubuntu-16-04-x64"
    name = "node2"
    region = "nyc3"
    size = "4gb"
    private_networking = true
    ssh_keys = [
     "${var.ssh_fingerprint}"
     ]
 provisioner "remote-exec" {
   inline = [
     "export PATH=$PATH:/usr/bin",
     # install nginx
     "sudo apt-get update",
     "sudo apt-get -y install nginx"
   ]
   connection {
       user = "root"
       type = "ssh"
       private_key = "${file(var.pvt_key)}"
       timeout = "2m"
   }
 }
    }
