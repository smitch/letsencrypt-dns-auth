# Overview
Scripts to get and renew wildcard Let’s encrypt certificate using dns auth in Conoha VPS.

# Install
No specific installation process is needed. Place code to somewhere in your server.

# Dependency
bash, curl, jq, Conoha VPS and your own domain.

# Usage
* configure
Rename vars.sample to vars. Set username, password, tenant id in vars.

* get cert
```
# certbot certonly --manual -d "*.<domain-name>" -m "<mail address>" --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /path/to/create-auth-record.sh --manual-cleanup-hook /path/to/delete-auth-record.sh
```

* renew cert
```
# certbot renew --manual -m "<mail address>" --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /path/to/create-auth-record.sh --manual-cleanup-hook /path/to/delete-auth-record.sh —-post-hook “systemctl restart httpd”
```
adding --quiet option is recommended for cron job.

# Licence
This software is released under the MIT License.
