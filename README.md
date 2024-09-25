- tuic env

```sh
TUIC_PORT=11234
TUIC_USER_UUID=c034e6d0-d814-44c3-9ed8-2aca9578c379
TUIC_USER_NAME=user
TUIC_USER_PWD=PWD
```

- uri `tuic://$TUIC_USER_UUID:$TUIC_USER_PWD@$ip:$TUIC_PORT?alpn=h3&allow_insecure=1&congestion_control=bbr#tuic-$ip`
