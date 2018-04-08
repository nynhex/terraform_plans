resource "digitalocean_droplet" "hadisruptsocial" {
    image = "ubuntu-16-04-x64"
    name = "lbdisruptsocial"
    region = "nyc3"
    size = "512mb"
    private_networking = true
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
  }
