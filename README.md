PowerDNS Authoritative Server on Alpine Linux
---

Official website: <https://powerdns.com>  
Current version: **4.3.1**

[![](https://images.microbadger.com/badges/image/magnaz/powerdns.svg)](https://microbadger.com/images/magnaz/powerdns "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/magnaz/powerdns.svg)](https://microbadger.com/images/magnaz/powerdns "Get your own version badge on microbadger.com")

Modules included:
 - [Generic MySQL backend (gmysql)](https://doc.powerdns.com/authoritative/backends/generic-mysql.html)
 - [Generic PostgreSQL backend (gpgsql)](https://doc.powerdns.com/authoritative/backends/generic-postgresql.html)

### Available tags:
 - latest, 4.3, 4.3.1
 - 4.3.0
 - 4.1.3

### Available SQL schemas
```bash
docker run --rm --entrypoint ls magnaz/powerdns /usr/local/share/doc/pdns
```

### Read default config file
```bash
docker run --rm --entrypoint cat magnaz/powerdns /etc/pdns.conf-dist
```

### Run
```bash
docker run --name=powerdns \
  --detach \
  --network=host \
  --volume=/local/path/to/pdns.conf:/etc/pdns.conf:ro \
  magnaz/powerdns
```
