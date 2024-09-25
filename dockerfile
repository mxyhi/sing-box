FROM gzxhwq/sing-box:latest AS base

WORKDIR /app

COPY . /app

EXPOSE 8080

CMD [ "/var/lib/sing-box", "run", "-c", "/app/conf/config.json", "-C", "/app/conf/conf" ]