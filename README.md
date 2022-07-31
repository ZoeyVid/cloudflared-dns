# Cloudflared-DNS

```yml
version: "3"
services:
    cloudflared:
        container_name: cloudflared-dns
        image: sancraftdev/cloudflared-dns:latest
#        image: sancraftdev/cloudflared-dns:develop
        restart: always
        network_mode: host
        environment:
        - "TZ=Europe/Berlin"
        - "upstream=https://dns.adguard-dns.com/dns-query"
#        entrypoint: cloudflared
#        command: --no-autoupdate # command to execute after cloudflared --no-autoupdate
```
<br>
Or run: 

```sh
docker run -e "TZ=Europe/Berlin" -e "upstream=https://dns.adguard-dns.com/dns-query" --net host --restart always --name cloudflared-dns sancraftdev/cloudflared-dns:latest
```
For development version run: 

```sh
docker run -e "TZ=Europe/Berlin" -e "upstream=https://dns.adguard-dns.com/dns-query" --net host --restart always --name cloudflared-dns sancraftdev/cloudflared-dns:develop
```
