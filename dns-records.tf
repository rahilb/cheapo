resource "digitalocean_record" "www" {
  domain = "bohra.co.uk"
  type   = "A"
  name   = "www"
  value  = digitalocean_droplet.nginx_server.ipv4_address
  ttl    = 120
}

resource "digitalocean_record" "root" {
  domain = "bohra.co.uk"
  type   = "A"
  name   = "@"
  value  = digitalocean_droplet.nginx_server.ipv4_address
  ttl    = 120
}
