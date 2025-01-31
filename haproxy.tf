resource "digitalocean_droplet" "lb" {
    image = "ubuntu-16-04-x64"
    name = "lb"
    region = "nyc3"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    provisioner "remote-exec" {
      inline = [
        "export PATH=$PATH:/usr/bin",
        # install haproxy 1.5
        "sudo add-apt-repository -y ppa:vbernat/haproxy-1.5",
        "sudo apt-get update",
        "sudo apt-get -y install haproxy",

        # download haproxy conf
        "sudo wget https://gist.githubusercontent.com/thisismitch/91815a582c27bd8aa44d/raw/8fc59b7cb88a2be9b802cd76288ca1c2ea957dd9/haproxy.cfg -O /etc/haproxy/haproxy.cfg",

        # replace ip address variables in haproxy conf to use droplet ip addresses
        "sudo sed -i 's/HAPROXY_PUBLIC_IP/${digitalocean_droplet.lb.ipv4_address}/g' /etc/haproxy/haproxy.cfg",
        "sudo sed -i 's/WWW_1_PRIVATE_IP/${digitalocean_droplet.node1.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",
        "sudo sed -i 's/WWW_2_PRIVATE_IP/${digitalocean_droplet.node2.ipv4_address_private}/g' /etc/haproxy/haproxy.cfg",

        # restart haproxy to load changes
        "sudo service haproxy restart"
      ]
      connection {
          user = "root"
          type = "ssh"
          private_key = "${file(var.pvt_key)}"
          timeout = "2m"
      }
    }
  }
