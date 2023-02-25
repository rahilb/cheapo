resource "digitalocean_droplet" "nginx_server" {
  image              = "ubuntu-18-04-x64"
  name               = "nginx-server"
  region             = "fra1"
  size               = var.droplet_class
  private_networking = true
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/secure-install.sh",
      "scripts/install-nginx.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /var/www/${var.domain_name}/html"
    ]
  }

  provisioner "file" {
    source      = "config/nginx/sites-available/${var.domain_name}"
    destination = "/etc/nginx/sites-available/${var.domain_name}"
  }

  provisioner "file" {
    source      = "static/index.html"
    destination = "/var/www/${var.domain_name}/html/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "ln -s /etc/nginx/sites-available/${var.domain_name} /etc/nginx/sites-enabled/",
      "nginx -t",
      "systemctl restart nginx"
    ]
  }

}
