FROM ghcr.io/sagernet/sing-box:latest AS base

WORKDIR /app

COPY . /app

EXPOSE 8080

ENTRYPOINT [ "/bin/bash", "-c" ]

CMD ["chmod 777 ./start.sh && ./start.sh"]