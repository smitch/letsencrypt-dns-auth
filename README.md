# Overview
Scripts to get and renew wildcard Let’s encrypt certificate using dns auth in Conoha VPS.

# Install
No specific installation process is needed. Place code to somewhere in your server.

# Dependency
certbot, bash, curl, jq, Conoha VPS and your own domain.

# Usage
* Configure

Rename vars.sample to vars. Set username, password, tenant id in vars.

* Get cert
```
# certbot certonly --manual -d "*.<domain-name>" -m "<mail address>" --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /path/to/create-auth-record.sh --manual-cleanup-hook /path/to/delete-auth-record.sh
```

* Renew cert
```
# certbot renew --manual -m "<mail address>" --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /path/to/create-auth-record.sh --manual-cleanup-hook /path/to/delete-auth-record.sh —-post-hook “systemctl restart httpd”
```
adding --quiet option is recommended for cron job.

＃Reference
* User name and password for Conoha api. https://www.conoha.jp/guide/apitokens.php
* DNS of Conoha. https://www.conoha.jp/guide/geodns.php
* Cert bot documents. https://certbot.eff.org/docs/using.html

# Licence
This software is released under the MIT License.
