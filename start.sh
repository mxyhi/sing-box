echo $'{
  "inbounds": [
    {
      "tag": "tuic-8080.json",
      "type": "tuic",
      "listen": "::",
      "listen_port": '$TUIC_PORT',
      "users": [
        {
          "name": "'$TUIC_USER_NAME'",
          "uuid": "'$TUIC_USER_UUID'",
          "password": "'$TUIC_USER_PWD'"
        }
      ],
      "congestion_control": "bbr",
      "tls": {
        "enabled": true,
        "alpn": ["h3"],
        "key_path": "/app/conf/tls/tls.key",
        "certificate_path": "/app/conf/tls/tls.cer"
      }
    }
  ]
}' >/app/conf/conf/tuic.json

_wget() {
    [[ $proxy ]] && export https_proxy=$proxy
    wget --no-check-certificate $*
}

get_ip() {
    export "$(_wget -4 -qO- https://one.one.one.one/cdn-cgi/trace | grep ip=)" &>/dev/null
    [[ -z $ip ]] && export "$(_wget -6 -qO- https://one.one.one.one/cdn-cgi/trace | grep ip=)" &>/dev/null
}

get_ip

is_addr=$ip

echo "tuic://$TUIC_USER_UUID:@$is_addr:$TUIC_PORT?alpn=h3&allow_insecure=1&congestion_control=bbr#tuic-$is_addr"

/usr/local/bin/sing-box run -c /app/conf/config.json -C /app/conf/conf
