resource "null_resource" "certbot_install" {

  depends_on = [
    digitalocean_record.root,
    digitalocean_record.www
  ]

  connection {
    host        = digitalocean_droplet.nginx_server.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.pvt_key)
    timeout     = "2m"
  }

  provisioner "file" {
    source      = "scripts/wait-for-dns.sh"
    destination = "/tmp/wait-for-dns.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "/tmp/wait-for-dns.sh '${digitalocean_droplet.nginx_server.ipv4_address}'",
      "certbot --nginx -d bohra.co.uk -d www.bohra.co.uk --non-interactive --agree-tos -m ${var.cert_contact} --debug-challenges",
    ]
  }

}
