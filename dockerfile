FROM gzxhwq/sing-box:latest AS base

WORKDIR /app

COPY . /app

CMD [ "bash -c '/var/lib/sing-box run -c /app/conf/config.json -C /app/conf/conf'" ]