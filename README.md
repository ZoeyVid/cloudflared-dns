# Cloudflared-DNS

```yml
version: "3"
services:
    cloudflared:
        container_name: cloudflared-dns
        image: zoeyvid/cloudflared-dns
        restart: always
        ports:
        - "127.0.0.1:53:53"
        - "127.0.0.1:53:53/udp"
        - "[::1]:53:53"
        - "[::1]:53:53/udp"
        environment:
        - "TZ=Europe/Berlin"
        - "upstream=https://dns.adguard-dns.com/dns-query"
#        entrypoint: cloudflared
#        command: --no-autoupdate # command to execute after cloudflared --no-autoupdate
        dns:
        - 9.9.9.9
        - 149.112.112.112
        - 2620:fe::fe
        - 2620:fe::fe:9
        - 1.1.1.2
        - 1.0.0.2
        - 2606:4700:4700::1112
        - 2606:4700:4700::1002
        - 94.140.14.14
        - 94.140.15.15
        - 2a10:50c0::ad1:ff
        - 2a10:50c0::ad2:ff
```
<br>
Or run: 

```sh
docker run -e "TZ=Europe/Berlin" -e "upstream=https://dns.adguard-dns.com/dns-query" -p "127.0.0.1:53:53" -p "127.0.0.1:53:53/udp" -p "[::1]:53:53" -p "[::1]:53:53/udp" --restart always --name cloudflared-dns --dns 9.9.9.9 --dns 149.112.112.112 --dns 2620:fe::fe --dns 2620:fe::fe:9 --dns 1.1.1.2 --dns 1.0.0.2 --dns 2606:4700:4700::1112 --dns 2606:4700:4700::1002 --dns 94.140.14.14 --dns 94.140.15.15 --dns 2a10:50c0::ad1:ff --dns 2a10:50c0::ad2:ff zoeyvid/cloudflared-dns
```

## Disable resolved (used on debian)
```sh
systemctl disable --now systemd-resolved
rm -rf /etc/resolv.conf
echo nameserver 127.0.0.1 >> /etc/resolv.conf
```
