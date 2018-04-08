resource "digitalocean_droplet" "disruptsocialnode1" {
    image = "ubuntu-16-04-x64"
    name = "node1.disrupsocial.network"
    region = "nyc3"
    size = "4gb"
    private_networking = true
    ssh_keys = [
     "${var.ssh_fingerprint}"
     ]
    }

resource "digitalocean_droplet" "disruptsocialnode2" {
    image = "ubuntu-16-04-x64"
    name = "node2.disrupsocial.network"
    region = "nyc3"
    size = "4gb"
    private_networking = true
    ssh_keys = [
     "${var.ssh_fingerprint}"
     ]
    }
