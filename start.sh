#!/bin/bash

source /app/config
echo $'{
  "inbounds": [
    {
      "tag": "tuic",
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
    # 尝试获取 IPv4 地址
    ip=$(wget -qO- https://one.one.one.one/cdn-cgi/trace | grep ip= | cut -d= -f2)

    # 如果 IPv4 地址为空，则尝试获取 IPv6 地址
    if [[ -z "$ip" ]]; then
        ip=$(wget -qO- https://one.one.one.one/cdn-cgi/trace | grep ip= | cut -d= -f2)
    fi

    # 输出 IP 地址
    if [[ -n "$ip" ]]; then
        echo "Your public IP address is: $ip"
    else
        echo "Failed to retrieve public IP address."
    fi
}

get_ip

is_addr=$ip

echo "url:"

echo ""

echo "tuic://$TUIC_USER_UUID:@$is_addr:$TUIC_PORT?alpn=h3&allow_insecure=1&congestion_control=bbr#tuic-$is_addr"

echo ""

/usr/local/bin/sing-box run -c /app/conf/config.json -C /app/conf/conf
