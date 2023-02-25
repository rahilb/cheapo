Contains terraform files for deploying an nginx server to digital ocean:

- Creates A records for @ and WWW
- Creates lets-encrypt certifcates and enables auto renewal

### TODO:

- don't run everything as root / security stuff
- change server to reverse proxy something cool
- maximise cheapness by running as many things as possible

### Running / Using

Rename `config/nginx/sites-avaialable/bohra.co.uk` to `config/nginx/sites-avaialable/example.com` and alter as required.

Create `env.tfvars` as required:

```
do_token      = "nice-try-kid"
pvt_key       = "~/.ssh/id_rsa"
cert_contact  = "user@example.com"
droplet_class = "s-1vcpu-512mb-10gb"
domain_name   = "example.com"
do_ssh_key_name = "id_rsa" # the name of the ssh_key in the DO control panel
```

`terraform init`
`terraform plan -out=infra.out -var-file=env.tfvars`
`terraform apply "infra.out"`

You might have to flush your dns cache, but you should see `static/index.html` served at `https://example.com` for ~$4/Month if using `s-1vcpu-512mb-10gb`.

### Destroying

`terraform plan -destroy -out=infra.out -var-file=env.tfvar`
`terraform apply "infra.out"`
