FROM gzxhwq/sing-box:latest AS base

WORKDIR /app

COPY . /app

EXPOSE 8080

ENTRYPOINT [ "bash" ]

CMD ["./start.sh"]