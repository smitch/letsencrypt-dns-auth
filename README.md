
# configure
set username, password, tenant id in vars

# run

* for cert
```
sudo certbot certonly --manual -d "*.<domain-name>" -m "<mail address>" --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /path/to/create-auth-record.sh --manual-cleanup-hook /path/to/delete-auth-record.sh
```

* for renew
```
certbot renew --manual -m "<mail address>" --agree-tos --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory --manual-auth-hook /path/to/create-auth-record.sh --manual-cleanup-hook /path/to/delete-auth-record.sh
```

